return {
	-- formatter
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format file",
			},
		},
		opts = {
			formatters_by_ft = {
				rust = { "rustfmt" },
				lua = { "stylua" },
				toml = { "taplo" },
				markdown = { "prettier" },
				go = { "goimports", "gofmt" },
				json = { "prettier" },
				jsonc = { "prettier" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				zig = { "zigfmt" },
				cs = { "csharpier" },
				python = { "ruff_format" },
				yaml   = { "prettier" },
				xml    = { "xmllint" },
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_fallback = true,
			},
		},
	},

	-- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<C-\\>", desc = "Toggle float terminal" },
			{ "<leader>j", desc = "Toggle horizontal terminal" },
			{ "<M-q>", desc = "Toggle Gemini CLI" },
			{ "<M-e>", desc = "Toggle Kilocode" },
		},
		config = function()
			require("toggleterm").setup({
				size = 15,
				shade_terminals = true,
				direction = "float",
				float_opts = { border = "curved" },
				shell = "powershell",
			})

			local Terminal = require("toggleterm.terminal").Terminal

			-- floating
			local float_term = Terminal:new({ direction = "float", hidden = true })
			vim.keymap.set({ "n", "t" }, "<C-\\>", function()
				float_term:toggle()
			end, { desc = "Toggle float terminal" })

			-- horizontal bottom pane
			local horiz_term = Terminal:new({ direction = "horizontal", size = 15, hidden = true })
			vim.keymap.set({ "n", "t" }, "<leader>j", function()
				horiz_term:toggle()
			end, { desc = "Toggle horizontal terminal" })

			-- Gemini CLI
			local gemini_term = Terminal:new({
				cmd = "gemini",
				direction = "float",
				hidden = true,
				float_opts = { border = "curved" },
			})
			vim.keymap.set({ "n", "t" }, "<M-q>", function()
				gemini_term:toggle()
			end, { desc = "Toggle Gemini CLI" })

			-- Kilocode
			local kilocode_term = Terminal:new({
				cmd = "kilocode",
				direction = "float",
				hidden = true,
				float_opts = { border = "curved" },
			})
			vim.keymap.set({ "n", "t" }, "<M-e>", function()
				kilocode_term:toggle()
			end, { desc = "Toggle Kilocode" })
		end,
	},

	-- hex editor
	{
		"RaafatTurki/hex.nvim",
		cmd = { "HexDump", "HexAssemble", "HexToggle" },
		keys = {
			{ "<leader>hx", "<cmd>HexToggle<CR>", desc = "Hex toggle" },
		},
		config = function()
			require("hex").setup()
		end,
	},

	-- Claude Code
	{
		"greggh/claude-code.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeDiff" },
		keys = {
			{ "<M-w>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code", mode = { "n", "t" } },
			{ "<leader>ar", "<cmd>ClaudeCodeContinue<CR>", desc = "Claude Code (resume)", mode = { "n" } },
		},
		opts = {
			window = {
				position = "float",
				width = 0.8,
				height = 0.8,
			},
		},
	},

	-- agentic.nvim: ACP protocol client for Neovim
	{
		"carlos-algms/agentic.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		event = "VeryLazy",
		lazy = true,
		init = function()
			-- Preload the module at parse time so that keymaps defined in `keys = { ... }`
			-- can call `require("agentic")` from inside their callbacks at lazy.nvim keymap
			-- dispatch time.
			pcall(require, "agentic")
		end,
		keys = {
			{
				"<leader>ac",
				function()
					-- require("agentic").open() is preferred instead of a Vim command

					return require("agentic").open()
				end,
				desc = "Open agentic chat",
			},
			{
				"<leader>af",
				function()
					return require("agentic").add_file()
				end,
				desc = "Pick file for agentic",
			},
			{
				"<leader>as",
				mode = "v",
				function()
					return require("agentic").add_selection_or_file_to_context()
				end,
				desc = "Send selection to agentic",
			},
		},
		opts = function()
			return {
				-- Each provider name is an arbitrary identifier; it maps to a command
				-- and args that the ACP client spawns via stdio transport
				acp_providers = {
					["kilocode-acp"] = {
						name = "Kilo Code ACP",
						command = "kilocode",
						-- Spawns: `kilocode acp`  (stdio / ACP proto)
						args = { "acp" },
						env = {
							NODE_NO_WARNINGS = "1",
							IS_AI_TERMINAL = "1",
						},
					},
				},
				provider = "kilocode-acp",
				--- keymaps are widget-local (inside the chat popup)
				keymaps = {},
				errors = {
					fatal = function(msg)
						vim.notify("[agentic] " .. msg, vim.log.levels.ERROR)
					end,
					non_fatal = function(msg)
						vim.notify("[agentic] " .. msg, vim.log.levels.WARN)
					end,
				},
			}
		end,
	},
}
