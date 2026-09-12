return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "InsertEnter",
		config = function()
			require("minuet").setup({
				provider = "codestral",
				provider_options = {
					codestral = {
						model = "codestral-latest",
						api_key = "CODESTRAL_API_KEY",
						optional = {
							max_tokens = 256,
							stop = { "\n\n" },
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					keymap = {
						accept = "<M-l>",
						accept_line = "<M-w>",
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-e>",
					},
				},
			})
		end,
	},
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
}
