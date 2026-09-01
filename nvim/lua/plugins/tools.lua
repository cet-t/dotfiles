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
				yaml = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				xml = { "xmllint" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
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
			{ "<leader>j", desc = "Toggle Nushell" },
			{ "<leader>kt", desc = "Toggle Kilocode" },
			{ "<leader>ct", desc = "Toggle Codex" },
		},
		config = function()
			require("toggleterm").setup({
				size = 15,
				shade_terminals = true,
				direction = "float",
				float_opts = { border = "curved" },
				shell = "nu",
			})

			local Terminal = require("toggleterm.terminal").Terminal

			-- Nushell
			local nu_term = Terminal:new({
				cmd = "nu",
				direction = "horizontal",
				hidden = true,
				size = math.floor(vim.o.lines * 0.35),
			})
			vim.keymap.set({ "n", "t" }, "<leader>j", function()
				nu_term:toggle(math.floor(vim.o.lines * 0.35))
			end, { desc = "Toggle float Nushell" })

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

			-- Codex
			local codex_term = Terminal:new({
				cmd = "codex",
				direction = "vertical",
				size = math.floor(vim.o.columns * 0.35),
				hidden = true,
			})
			vim.keymap.set({ "n", "t" }, "<leader>ct", function()
				codex_term:toggle(math.floor(vim.o.columns * 0.35))
			end, { desc = "Toggle Codex" })
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
}
