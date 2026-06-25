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
				javascript      = { "prettier" },
				javascriptreact = { "prettier" },
				typescript      = { "prettier" },
				typescriptreact = { "prettier" },
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
			{ "<leader>kt", desc = "Toggle Kilocode" },
			{ "<leader>gg", desc = "Toggle gitui" },
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
				direction = "vertical",
				size = math.floor(vim.o.columns * 0.35),
				hidden = true,
			})
			vim.keymap.set({ "n", "t" }, "<leader>kt", function()
				kilocode_term:toggle(math.floor(vim.o.columns * 0.35))
			end, { desc = "Toggle Kilocode" })

			-- gitui
			local gitui_term = Terminal:new({
				cmd = "gitui",
				direction = "float",
				hidden = true,
				float_opts = { border = "curved", winblend = 15 },
			})
			vim.keymap.set({ "n", "t" }, "<leader>gg", function()
				gitui_term:toggle()
			end, { desc = "Toggle gitui" })
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
}
