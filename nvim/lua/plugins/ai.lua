return {
	{
		"greggh/claude-code.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeDiff" },
		keys = {
			{ "<M-q>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code", mode = { "n", "t" } },
			{ "<leader>ar", "<cmd>ClaudeCodeContinue<CR>", desc = "Claude Code (resume)", mode = { "n" } },
		},
		opts = {
			window = {
				position = "float",
				width = 0.8,
				height = 0.8,
			},
		},
		config = function(_, opts)
			require("claude-code").setup(opts)
			-- Semi-transparent float: initial open
			vim.api.nvim_create_autocmd("TermOpen", {
				pattern = "*claude*",
				callback = function()
					vim.wo.winblend = 10
				end,
			})
			-- Semi-transparent float: re-show existing buffer
			vim.api.nvim_create_autocmd("BufWinEnter", {
				pattern = "claude-code*",
				callback = function()
					vim.wo.winblend = 10
				end,
			})
		end,
	},
	{
		"NakLast/antigravity-cli.nvim",
		cmd = { "Antigravity" },
		keys = {
			{ "<M-w>", "<cmd>Antigravity<CR>", desc = "Toggle Antigravity", mode = { "n", "t" } },
		},
		opts = {
			cmd = "agy",
			style = "float", -- plugin default is "vsplit"
			width_ratio = 0.8,
			height_ratio = 0.8,
		},
		config = function(_, opts)
			require("antigravity").setup(opts)
			-- Semi-transparent float: initial open / re-show existing buffer
			vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
				pattern = "term://*:agy",
				callback = function()
					vim.wo.winblend = 10
				end,
			})
		end,
	},
}
