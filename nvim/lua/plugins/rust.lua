return {
	-- Rust dev (handles rust-analyzer automatically)
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false,
		ft = "rust",
		config = function()
			vim.g.rustaceanvim = {
				tools = {
					hover_actions = { auto_focus = true },
				},
				server = {
					on_attach = function(_, bufnr)
						local map = function(keys, func, desc)
							vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
						end
						map("gd", vim.lsp.buf.definition, "Go to definition")
						map("gD", vim.lsp.buf.declaration, "Go to declaration")
						map("gr", vim.lsp.buf.references, "References")
						map("gi", vim.lsp.buf.implementation, "Implementation")
						map("K", vim.lsp.buf.hover, "Hover docs")
						map("<leader>ca", vim.lsp.buf.code_action, "Code action")
						map("<leader>rn", vim.lsp.buf.rename, "Rename")
						map("<leader>f", function()
							vim.lsp.buf.format({ async = true })
						end, "Format")
						-- Rust-specific
						map("<leader>rr", "<cmd>RustLsp runnables<CR>", "Rust runnables")
						map("<leader>rt", "<cmd>RustLsp testables<CR>", "Rust testables")
						map("<leader>re", "<cmd>RustLsp expandMacro<CR>", "Expand macro")
						map("<leader>rd", "<cmd>RustLsp debuggables<CR>", "Rust debuggables")
						map("<leader>rc", "<cmd>RustLsp openCargo<CR>", "Open Cargo.toml")
					end,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = { command = "clippy" },
							inlayHints = {
								bindingModeHints = { enable = true },
								chainingHints = { enable = true },
								closureReturnTypeHints = { enable = "always" },
								parameterHints = { enable = true },
								typeHints = { enable = true },
							},
							cargo = { allFeatures = true },
						},
					},
				},
			}
		end,
	},

	-- TOML support (Cargo.toml)
	{
		"saecki/crates.nvim",
		event = "BufRead Cargo.toml",
		opts = {},
	},
}
