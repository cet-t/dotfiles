return {
	-- {
	-- 	"greggh/claude-code.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeDiff" },
	-- 	keys = {
	-- 		{ "<M-q>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code", mode = { "n", "t" } },
	-- 		{ "<leader>ar", "<cmd>ClaudeCodeContinue<CR>", desc = "Claude Code (resume)", mode = { "n" } },
	-- 	},
	-- 	opts = {
	-- 		window = {
	-- 			position = "float",
	-- 			width = 0.8,
	-- 			height = 0.8,
	-- 		},
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("claude-code").setup(opts)
	-- 		-- Semi-transparent float: initial open
	-- 		vim.api.nvim_create_autocmd("TermOpen", {
	-- 			pattern = "*claude*",
	-- 			callback = function()
	-- 				vim.wo.winblend = 10
	-- 			end,
	-- 		})
	-- 		-- Semi-transparent float: re-show existing buffer
	-- 		vim.api.nvim_create_autocmd("BufWinEnter", {
	-- 			pattern = "claude-code*",
	-- 			callback = function()
	-- 				vim.wo.winblend = 10
	-- 			end,
	-- 		})
	-- 	end,
	-- },
	{
		"ishiooon/codex.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<M-q>", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
			-- { "<leader>cf", "<cmd>CodexFocus<cr>", desc = "Codex: Focus" },
			{ "<leader>cm", "<cmd>CodexMaximizeToggle<cr>", desc = "Codex: Toggle modal" },
			{ "<leader>cs", "<cmd>CodexSend<cr>", mode = "v", desc = "Codex: Send selection" },
			{
				"<leader>cs",
				"<cmd>CodexTreeAdd<cr>",
				desc = "Codex: Add file",
				ft = { "neo-tree", "oil" },
			},
		},
	},
}
