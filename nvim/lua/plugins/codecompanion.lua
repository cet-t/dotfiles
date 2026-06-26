return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionSave", "CodeCompanionLoad" },
		keys = {
			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat", mode = { "n", "v" } },
			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "AI Actions", mode = { "n", "v" } },
			{ "<leader>ae", "<cmd>CodeCompanion<CR>", desc = "AI Inline edit", mode = { "v" } },
			{ "<leader>as", "<cmd>CodeCompanionSave<CR>", desc = "AI Save chat", mode = { "n" } },
			{ "<leader>al", "<cmd>CodeCompanionLoad<CR>", desc = "AI Load chat", mode = { "n" } },
			{ "<leader>ab", "ggVG:CodeCompanionChat Add<CR>", desc = "AI Add buffer to chat", mode = { "n" } },
		},
		config = function()
			require("codecompanion").setup({
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
			})

			-- Session save/load
			local Path = require("plenary.path")
			local save_dir = Path:new(vim.fn.stdpath("data"), "codecompanion", "sessions")
			if not save_dir:exists() then
				save_dir:mkdir({ parents = true })
			end

			-- :CodeCompanionSave [title words...]  →  saves buffer as title-words.md
			-- :CodeCompanionSave                   →  saves with timestamp
			vim.api.nvim_create_user_command("CodeCompanionSave", function(opts)
				local ok, chat = pcall(function()
					return require("codecompanion").buf_get_chat(0)
				end)
				if not ok or chat == nil then
					vim.notify("CodeCompanionSave: チャットバッファ以外では使えません", vim.log.levels.ERROR)
					return
				end

				local name = #opts.fargs > 0
					and table.concat(opts.fargs, "-") .. ".md"
					or os.date("%Y%m%d-%H%M%S") .. ".md"

				local path = Path:new(save_dir, name)
				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
				path:write(table.concat(lines, "\n"), "w")
				vim.notify("保存: " .. name, vim.log.levels.INFO)
			end, { nargs = "*" })

			-- :CodeCompanionLoad  →  snacks picker でセッション選択（<c-d> で削除）
			vim.api.nvim_create_user_command("CodeCompanionLoad", function()
				local dir = save_dir:absolute()
				require("snacks").picker.files({
					title = "Saved CodeCompanion Sessions",
					cwd = dir,
					actions = {
						delete_session = function(picker, item)
							if item then
								local path = Snacks.picker.util.path(item)
								if path then
									os.remove(path)
									picker:refresh()
									vim.notify("削除: " .. vim.fn.fnamemodify(path, ":t"), vim.log.levels.INFO)
								end
							end
						end,
					},
					win = {
						input = {
							keys = {
								["<c-x>"] = { "delete_session", mode = { "i", "n" }, desc = "セッション削除" },
							},
						},
						list = {
							keys = {
								["<c-x>"] = { "delete_session", desc = "セッション削除" },
							},
						},
					},
				})
			end, {})
		end,
	},
}
