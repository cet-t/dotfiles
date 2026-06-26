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
				separator_style = "slant",
			},
		},
	},

	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
			{ "<leader>e", "<cmd>Oil --float<CR>", desc = "Oil (float)" },
		},
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
			},
			float = {
				padding = 2,
				max_width = 80,
				max_height = 40,
				win_options = { winblend = 10 },
			},
			keymaps = {
				["<CR>"] = "actions.select",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",
			},
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "melange",
				globalstatus = true,
			},
			sections = {
				lualine_c = { { "filename", path = 1 } },
			},
		},
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
