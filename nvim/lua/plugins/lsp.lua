local on_attach = function(_, bufnr)
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
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "hrsh7th/cmp-nvim-lsp" },
		config = function()
			local caps = require("cmp_nvim_lsp").default_capabilities()

			-- C / C++
			if vim.fn.executable("clangd") == 1 then
				vim.lsp.config("clangd", {
					on_attach = on_attach,
					capabilities = caps,
					cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
					filetypes = { "c", "cpp", "objc", "objcpp" },
					root_markers = { "compile_commands.json", "CMakeLists.txt", ".git" },
				})
				vim.lsp.enable("clangd")
			end

			-- C#
			if vim.fn.executable("csharp-ls") == 1 then
				vim.lsp.config("csharp_ls", {
					on_attach = on_attach,
					capabilities = caps,
					root_markers = { "*.sln", "*.csproj", ".git" },
				})
				vim.lsp.enable("csharp_ls")
			end

			-- Zig
			if vim.fn.executable("zls") == 1 then
				vim.lsp.config("zls", {
					on_attach = on_attach,
					capabilities = caps,
					root_markers = { "build.zig", ".git" },
				})
				vim.lsp.enable("zls")
			end

			-- Python
			if vim.fn.executable("pyright") == 1 then
				vim.lsp.config("pyright", {
					on_attach = on_attach,
					capabilities = caps,
					settings = {
						python = {
							analysis = {
								typeCheckingMode = "basic",
								autoImportCompletions = true,
							},
						},
					},
					root_markers = { "pyproject.toml", "setup.py", "setup.cfg", ".git" },
				})
				vim.lsp.enable("pyright")
			end
		end,
	},
}
