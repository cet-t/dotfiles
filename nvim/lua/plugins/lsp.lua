local on_attach = function(_, bufnr)
  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
  end
  map("gd",         vim.lsp.buf.definition,                               "Go to definition")
  map("gD",         vim.lsp.buf.declaration,                              "Go to declaration")
  map("gr",         vim.lsp.buf.references,                               "References")
  map("gi",         vim.lsp.buf.implementation,                           "Implementation")
  map("K",          vim.lsp.buf.hover,                                    "Hover docs")
  map("<leader>ca", vim.lsp.buf.code_action,                              "Code action")
  map("<leader>rn", vim.lsp.buf.rename,                                   "Rename")
  map("<leader>f",  function() vim.lsp.buf.format({ async = true }) end,  "Format")
end

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- C / C++
      vim.lsp.config("clangd", {
        on_attach = on_attach,
        capabilities = caps,
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_markers = { "compile_commands.json", "CMakeLists.txt", ".git" },
      })
      vim.lsp.enable("clangd")

      -- Zig
      vim.lsp.config("zls", {
        on_attach = on_attach,
        capabilities = caps,
        root_markers = { "build.zig", ".git" },
      })
      vim.lsp.enable("zls")
    end,
  },
}
