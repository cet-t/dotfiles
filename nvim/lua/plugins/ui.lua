return {
	{
		"DaikyXendo/nvim-material-icon",
		priority = 100,
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	{
		"famiu/bufdelete.nvim",
		keys = {
			{ "<leader>q", "<cmd>Bdelete<CR>", desc = "Close buffer" },
		},
	},

	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				offsets = {},
				show_buffer_close_icons = true,
				separator_style = "thin",
			},
		},
	},

	{
		"FylerOrg/fyler.nvim",
		keys = {
			{
				"<leader>e",
				function() require("fyler").open() end,
				desc = "Fyler: open",
			},
			{
				"-",
				function() require("fyler").open({ root_path = vim.fn.expand("%:p:h") }) end,
				desc = "Fyler: open current dir",
			},
		},
		opts = {},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			local spinner_index = 1
			local processing = false
			local timer = nil

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestStarted",
				callback = function()
					processing = true
					if not timer then
						timer = vim.uv.new_timer()
						timer:start(
							0,
							100,
							vim.schedule_wrap(function()
								spinner_index = (spinner_index % #spinner_frames) + 1
								vim.cmd("redrawstatus")
							end)
						)
					end
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				pattern = "CodeCompanionRequestFinished",
				callback = function()
					processing = false
					if timer then
						timer:stop()
						timer:close()
						timer = nil
					end
					vim.cmd("redrawstatus")
				end,
			})

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
				},
				sections = {
					lualine_c = { { "filename", path = 1 } },
					lualine_x = {
						{
							function()
								if processing then
									return spinner_frames[spinner_index] .. " AI"
								end
								return ""
							end,
						},
						"encoding",
						"fileformat",
						"filetype",
					},
				},
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},

	{
		"lewis6991/satellite.nvim",
		event = "BufReadPre",
		opts = {
			current_only = false,
			winblend = 50,
			handlers = {
				cursor = { enable = true },
				gitsigns = { enable = true },
				diagnostic = { enable = true, signs = { "-", "=", "≡" } },
				search = { enable = true },
			},
		},
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			max_width = 40,
			max_height = 5,
			render = "compact",
			stages = "fade",
		},
		config = function(_, opts)
			require("notify").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "notify",
				callback = function()
					vim.wo.winblend = 20
				end,
			})
		end,
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = {
				hover = { enabled = true },
				signature = { enabled = true },
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				lsp_doc_border = true,
			},
		},
	},
}
