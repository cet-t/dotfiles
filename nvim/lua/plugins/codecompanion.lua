return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat",        mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>",     desc = "AI Actions",     mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion<CR>",            desc = "AI Inline edit", mode = { "v" } },
		},
		opts = {
			adapters = {
				gemini = function()
					return require("codecompanion.adapters").extend("gemini", {
						env = { api_key = "GEMINI_API_KEY" },
						schema = {
							model = { default = "gemini-2.5-pro-preview-05-06" },
						},
					})
				end,
			},
			strategies = {
				chat   = { adapter = "gemini" },
				inline = { adapter = "gemini" },
				agent  = { adapter = "gemini" },
			},
			display = {
				chat = {
					window = {
						layout = "vertical",
						width = 0.35,
					},
				},
			},
		},
	},
}
