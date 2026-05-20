return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat",               mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>",     desc = "AI Actions",            mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion<CR>",            desc = "AI Inline edit",        mode = { "v" } },
			{ "<leader>as", "<cmd>CodeCompanionChat Save<CR>",   desc = "AI Save chat",          mode = { "n" } },
			{ "<leader>al", "<cmd>CodeCompanionChat Load<CR>",   desc = "AI Load chat",          mode = { "n" } },
			{ "<leader>ab", "ggVG:CodeCompanionChat Add<CR>",    desc = "AI Add buffer to chat", mode = { "n" } },
		},
		opts = {
			adapters = {
				http = {
					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							env = { api_key = "GEMINI_API_KEY" },
							schema = {
								model = {
									default = "gemini-3-flash-preview",
									choices = {
										"gemini-3-flash-preview",
										"gemini-3.1-flash-lite",
										"gemini-3.1-flash",
										"gemini-3.1-pro-preview",
									},
								},
							},
						})
					end,
					grok = function()
						return require("codecompanion.adapters").extend("xai", {
							schema = {
								model = {
									default = "grok-4.3",
									choices = {
										"grok-4.3",
										"grok-3-mini-fast",
									},
								},
							},
						})
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "gemini",
					opts = {
						system_prompt = function() return "Always respond in Japanese." end,
					},
					slash_commands = {
						["file"] = { opts = { provider = "telescope" } },
					},
				},
				inline = { adapter = "gemini" },
				agent  = { adapter = "gemini" },
			},
			rules = {
				default = { files = {} },
			},
			saved_chats_dir = vim.fn.stdpath("data") .. "/codecompanion/chats",
			display = {
				chat = {
					window = {
						layout = "vertical",
						width = 0.35,
					},
				},
				action_palette = {
					opts = {
						show_prompt_library_builtins = false,
					},
				},
			},
		},
	},
}
