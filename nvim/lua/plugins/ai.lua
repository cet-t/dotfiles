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
		"nickjvandyke/opencode.nvim",
		version = "*",
		dependencies = {
			{
				"folke/snacks.nvim",
				lazy = false,
				priority = 1000,
				opts = {
					input = {},
					picker = {},
				},
			},
		},
		config = function()
			vim.g.opencode_opts = {}

			vim.o.autoread = true

			local map = vim.keymap.set

			map({ "n", "t" }, "<leader>ot", function()
				require("opencode").ask()
			end, { desc = "Toggle OpenCode" })

			map({ "n", "x" }, "<leader>oa", function()
				require("opencode").prompt("@this: ")
			end, { desc = "OpenCode: ask about selection" })

			map({ "n", "x" }, "<leader>os", function()
				require("opencode").select()
			end, { desc = "OpenCode: select prompt" })

			map("n", "<leader>on", function()
				require("opencode").command("session.new")
			end, { desc = "OpenCode: new session" })

			map("n", "<leader>ou", function()
				require("opencode").command("session.undo")
			end, { desc = "OpenCode: undo" })

			map("n", "<leader>or", function()
				require("opencode").command("session.redo")
			end, { desc = "OpenCode: redo" })

			map({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "OpenCode: add range", expr = true })

			map("n", "<C-k>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "OpenCode: scroll up" })

			map("n", "<C-j>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "OpenCode: scroll down" })
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
