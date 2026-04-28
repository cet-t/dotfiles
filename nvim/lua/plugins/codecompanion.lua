return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat",            mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>",     desc = "AI Actions",         mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion<CR>",            desc = "AI Inline edit",     mode = { "v" } },
		},
		opts = {
			adapters = {
				lmstudio = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						name = "lmstudio",
						env = {
							url = "http://localhost:1234",
							api_key = "lm-studio",
						},
						schema = {
							model = {
								default = "local-model",
							},
						},
					})
				end,
			},
			strategies = {
				chat   = { adapter = "lmstudio" },
				inline = { adapter = "lmstudio" },
				agent  = { adapter = "lmstudio" },
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
