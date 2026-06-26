return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat", mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "AI Actions", mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion<CR>", desc = "AI Inline edit", mode = { "v" } },
			{ "<leader>as", "<cmd>CodeCompanionChat Save<CR>", desc = "AI Save chat", mode = { "n" } },
			{ "<leader>al", "<cmd>CodeCompanionChat Load<CR>", desc = "AI Load chat", mode = { "n" } },
			{ "<leader>ab", "ggVG:CodeCompanionChat Add<CR>", desc = "AI Add buffer to chat", mode = { "n" } },
		},
		opts = {
			opts = { language = "Japanese" },
			adapters = {
				http = {
					gemini = function()
						return require("codecompanion.adapters").extend("gemini", {
							env = { api_key = "GEMINI_API_KEY" },
							schema = {
								model = {
									default = "gemini-3-flash-preview",
									choices = {
										"gemini-3.1-flash-lite",
										"gemini-3.5-flash",
										"gemini-3.1-pro-preview",
									},
								},
							},
						})
					end,
					xai = function()
						return require("codecompanion.adapters").extend("xai", {
							env = { api_key = "XAI_API_KEY" },
							schema = {
								model = {
									default = "grok-build-0.1",
									choice = {
										"grok-build-0.1",
										"grok-4.3",
									},
								},
							},
						})
					end,
					sakana = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							env = {
								api_key = "SAKANA_API_KEY",
								url = "https://api.sakana.ai",
							},
							schema = {
								model = {
									default = "fugu",
									choices = {
										"fugu",
										-- "fugu-ultra"
									},
								},
							},
						})
					end,
				},
			},
			strategies = {
				chat = {
					adapter = "sakana",
					opts = {
						system_prompt = function()
							return ""
						end,
					},
					slash_commands = {
						["buffer"] = { opts = { provider = "snacks" } },
						["file"] = { opts = { provider = "snacks" } },
						["help"] = { opts = { provider = "snacks" } },
						["symbols"] = { opts = { provider = "snacks" } },
						["workspace"] = { opts = { provider = "snacks" } },
					},
				},
				inline = { adapter = "gemini" },
				agent = { adapter = "gemini" },
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
