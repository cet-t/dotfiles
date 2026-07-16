return {
	--	{
	--		"olimorris/codecompanion.nvim",
	--		dependencies = {
	--			"nvim-lua/plenary.nvim",
	--			"nvim-treesitter/nvim-treesitter",
	--		},
	--		cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionSave", "CodeCompanionLoad" },
	--		keys = {
	--			{ "<leader>ai", "<cmd>CodeCompanionChat Toggle<CR>", desc = "AI Chat", mode = { "n", "v" } },
	--			{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "AI Actions", mode = { "n", "v" } },
	--			{ "<leader>ae", "<cmd>CodeCompanion<CR>", desc = "AI Inline edit", mode = { "v" } },
	--			{ "<leader>as", "<cmd>CodeCompanionSave<CR>", desc = "AI Save chat", mode = { "n" } },
	--			{ "<leader>al", "<cmd>CodeCompanionLoad<CR>", desc = "AI Load chat", mode = { "n" } },
	--			{ "<leader>ab", "ggVG:CodeCompanionChat Add<CR>", desc = "AI Add buffer to chat", mode = { "n" } },
	--		},
	--		config = function()
	--			require("codecompanion").setup({
	--				opts = { language = "Japanese" },
	--				adapters = {
	--					http = {
	--						openrouter = function()
	--							return require("codecompanion.adapters").extend("openai_compatible", {
	--								env = { api_key = "OPENROUTER_API_KEY" },
	--								schema = {
	--									model = {
	--										default = "deepseek-ai/DeepSeek-V4-Flash",
	--										choices = {
	--											-- deepinfra
	--											"deepseek-ai/DeepSeek-V4-Flash", -- 0.10 / 0.20
	--											"deepseek-ai/DeepSeek-V4-Pro", -- 1.30 / 2.60
	--											"XiaomiMiMo/MiMo-V2.5", -- 0.40 / 2.00
	--											"XiaomiMiMo/MiMo-V2.5-Pro", -- 1.00 / 3.00
	--											"zai-org/GLM-5.2", -- 0.95 / 3.00
	--											"moonshotai/Kimi-K2.7-Code", -- 0.74 / 3.50
	--											"MiniMaxAI/MiniMax-M2.7", -- 0.25 / 1.00
	--
	--											-- google
	--											"google/gemini-2.5-flash-lite",
	--											"google/gemini-3.1-flash-lite",
	--											"google/gemini-3.1-pro-preview",
	--											"google/gemini-3.5-flash",
	--
	--											-- stepfun
	--											"stepfun/step-3.7-flash",
	--
	--											-- xiaomi
	--											"xiaomi/mimo-v2.5",
	--											"xiaomi/mimo-v2.5-pro",
	--
	--											-- deepseek
	--											"deepseek/deepseek-v4-flash",
	--											"deepseek/deepseek-v4-pro",
	--
	--											-- mistral
	--											-- xai
	--											"x-ai/grok-build-0.1",
	--											"x-ai/grok-4.3",
	--
	--											-- zai
	--											"z-ai/glm-5.2",
	--										},
	--									},
	--								},
	--							})
	--						end,
	--						gemini = function()
	--							return require("codecompanion.adapters").extend("gemini", {
	--								env = { api_key = "GEMINI_API_KEY" },
	--								schema = {
	--									model = {
	--										default = "gemini-3-flash-preview",
	--										choices = {
	--											"gemini-3.1-flash-lite",
	--											"gemini-3.5-flash",
	--											"gemini-3.1-pro-preview",
	--										},
	--									},
	--								},
	--							})
	--						end,
	--						xai = function()
	--							return require("codecompanion.adapters").extend("xai", {
	--								env = { api_key = "XAI_API_KEY" },
	--								schema = {
	--									model = {
	--										default = "grok-build-0.1",
	--										choice = {
	--											"grok-build-0.1",
	--											"grok-4.3",
	--										},
	--									},
	--								},
	--							})
	--						end,
	--						sakana = function()
	--							return require("codecompanion.adapters").extend("openai_compatible", {
	--								env = {
	--									api_key = "SAKANA_API_KEY",
	--									url = "https://api.sakana.ai",
	--								},
	--								schema = {
	--									model = {
	--										default = "fugu",
	--										choices = {
	--											"fugu",
	--											"fugu-ultra",
	--										},
	--									},
	--								},
	--							})
	--						end,
	--					},
	--				},
	--				strategies = {
	--					chat = {
	--						adapter = "sakana",
	--						opts = {
	--							system_prompt = function()
	--								return ""
	--							end,
	--						},
	--						slash_commands = {
	--							["buffer"] = { opts = { provider = "snacks" } },
	--							["file"] = { opts = { provider = "snacks" } },
	--							["help"] = { opts = { provider = "snacks" } },
	--							["symbols"] = { opts = { provider = "snacks" } },
	--							["workspace"] = { opts = { provider = "snacks" } },
	--							["model"] = {
	--								description = "モデルを切り替える",
	--								callback = function(chat)
	--									require("codecompanion.interactions.chat.keymaps.change_adapter").select_model(chat)
	--								end,
	--							},
	--						},
	--					},
	--					inline = { adapter = "gemini" },
	--					agent = { adapter = "gemini" },
	--				},
	--				rules = {
	--					default = { files = {} },
	--				},
	--				extensions = {
	--					compress = {
	--						callback = require("cc_compress"),
	--						opts = {
	--							max_messages = 20,
	--							limits = {
	--								user = math.huge,
	--								assistant = 5000,
	--								tool = 500,
	--								system = math.huge,
	--							},
	--						},
	--					},
	--				},
	--				saved_chats_dir = vim.fn.stdpath("data") .. "/codecompanion/chats",
	--				display = {
	--					chat = {
	--						window = {
	--							layout = "vertical",
	--							width = 0.35,
	--						},
	--					},
	--					action_palette = {
	--						opts = {
	--							show_prompt_library_builtins = false,
	--						},
	--					},
	--				},
	--			})
	--
	--			-- Session save/load
	--			local Path = require("plenary.path")
	--			local save_dir = Path:new(vim.fn.stdpath("data"), "codecompanion", "sessions")
	--			if not save_dir:exists() then
	--				save_dir:mkdir({ parents = true })
	--			end
	--
	--			-- :CodeCompanionSave [title words...]  →  saves buffer as title-words.md
	--			-- :CodeCompanionSave                   →  saves with timestamp
	--			vim.api.nvim_create_user_command("CodeCompanionSave", function(opts)
	--				local ok, chat = pcall(function()
	--					return require("codecompanion").buf_get_chat(0)
	--				end)
	--				if not ok or chat == nil then
	--					vim.notify(
	--						"CodeCompanionSave: チャットバッファ以外では使えません",
	--						vim.log.levels.ERROR
	--					)
	--					return
	--				end
	--
	--				local name = #opts.fargs > 0 and table.concat(opts.fargs, "-") .. ".md"
	--					or os.date("%Y%m%d-%H%M%S") .. ".md"
	--
	--				local path = Path:new(save_dir, name)
	--				local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	--				path:write(table.concat(lines, "\n"), "w")
	--				vim.notify("保存: " .. name, vim.log.levels.INFO)
	--			end, { nargs = "*" })
	--
	--			-- :CodeCompanionLoad  →  snacks picker でセッション選択（<c-d> で削除）
	--			vim.api.nvim_create_user_command("CodeCompanionLoad", function()
	--				local dir = save_dir:absolute()
	--				require("snacks").picker.files({
	--					title = "Saved CodeCompanion Sessions",
	--					cwd = dir,
	--					actions = {
	--						delete_session = function(picker, item)
	--							if item then
	--								local path = Snacks.picker.util.path(item)
	--								if path then
	--									os.remove(path)
	--									picker:refresh()
	--									vim.notify("削除: " .. vim.fn.fnamemodify(path, ":t"), vim.log.levels.INFO)
	--								end
	--							end
	--						end,
	--					},
	--					win = {
	--						input = {
	--							keys = {
	--								["<c-x>"] = { "delete_session", mode = { "i", "n" }, desc = "セッション削除" },
	--							},
	--						},
	--						list = {
	--							keys = {
	--								["<c-x>"] = { "delete_session", desc = "セッション削除" },
	--							},
	--						},
	--					},
	--				})
	--			end, {})
	--		end,
	--	},

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
		"ishiooon/codex.nvim",
		dependencies = { "folke/snacks.nvim" },
		cmd = { "Codex", "CodexFocus", "CodexSend", "CodexTreeAdd" },
		keys = {
			{ "<leader>cx", "<cmd>Codex<cr>", desc = "Codex: Toggle" },
			{ "<leader>cX", "<cmd>CodexFocus<cr>", desc = "Codex: Focus" },
			{ "<leader>cs", "<cmd>CodexSend<cr>", mode = "v", desc = "Codex: Send selection" },
			{
				"<leader>cs",
				"<cmd>CodexTreeAdd<cr>",
				desc = "Codex: Add file",
				ft = { "neo-tree", "oil" },
			},
		},
		opts = {},
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
