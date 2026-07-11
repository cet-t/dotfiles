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
			{ "<leader>j", desc = "Toggle float terminal(nu)" },
			{ "<leader>kt", desc = "Toggle Kilocode" },
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

			-- floating terminal (nushell, semi-transparent)
			local nu_term = Terminal:new({
				cmd = "nu",
				direction = "float",
				hidden = true,
				float_opts = { border = "curved", winblend = 15 },
			})
			vim.keymap.set({ "n", "t" }, "<leader>j", function()
				nu_term:toggle()
			end, { desc = "Toggle float terminal(nu)" })

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
