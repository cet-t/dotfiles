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
			{ "<M-w>", "<cmd>ClaudeCode<CR>", desc = "Claude Code", mode = { "n" } },
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
}
