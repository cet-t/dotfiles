return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = { path_display = { "truncate" } },
			})
			pcall(telescope.load_extension, "fzf")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"lua",
					"rust",
					"toml",
					"markdown",
					"markdown_inline",
					"bash",
					"json",
					"c",
					"cpp",
					"zig",
					"c_sharp",
					"python",
				},
			})
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		opts = {},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
			},
		},
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		config = function()
			local s = require("smart-splits")
			-- resize
			vim.keymap.set("n", "<leader>wk", s.resize_up, { desc = "Resize up" })
			vim.keymap.set("n", "<leader>wj", s.resize_down, { desc = "Resize down" })
			vim.keymap.set("n", "<leader>wh", s.resize_left, { desc = "Resize left" })
			vim.keymap.set("n", "<leader>wl", s.resize_right, { desc = "Resize right" })
			vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
			-- window move
			vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left window" })
			vim.keymap.set("n", "<C-Down>", "<C-w>j", { desc = "Move to lower window" })
			vim.keymap.set("n", "<C-Up>", "<C-w>k", { desc = "Move to upper window" })
			vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right window" })
		end,
	},

	-- Error Lens: inline diagnostics on same line
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				options = {
					show_source = true,
					throttle = 20,
					softwrap = 30,
				},
			})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},

	-- Trouble: diagnostics panel
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location list" },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
		},
		opts = { use_diagnostic_signs = true },
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			heading = {
				sign = false,
				icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
				backgrounds = {
					"RenderMarkdownH1Bg",
					"RenderMarkdownH2Bg",
					"RenderMarkdownH3Bg",
					"RenderMarkdownH4Bg",
					"RenderMarkdownH5Bg",
					"RenderMarkdownH6Bg",
				},
			},
			code = {
				sign = false,
				style = "full",
				border = "thin",
				above = "▄",
				below = "▀",
				language_pad = 1,
			},
			bullet = {
				icons = { "●", "○", "◆", "◇" },
			},
			checkbox = {
				unchecked = { icon = "󰄱 " },
				checked = { icon = "󰱒 " },
			},
			pipe_table = { style = "full" },
			hr = { icon = "─" },
			quote = { icon = "▎" },
		},
	},

	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		pin = true,
		build = "cd app && npm install && git checkout -- yarn.lock",
		cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", desc = "Markdown preview" },
		},
		init = function()
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_theme = "dark"
		end,
	},
}
