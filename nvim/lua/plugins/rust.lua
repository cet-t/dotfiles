return {
  -- completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = {
              Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "",
              Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "",
              Module = "", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
              Enum = "", Keyword = "󰌋", Snippet = "", Color = "󰏘",
              File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "",
              Constant = "󰏿", Struct = "󰙅", Event = "", Operator = "󰆕",
              TypeParameter = "",
            }
            item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)
            return item
          end,
        },
      })
    end,
  },

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
            map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format")
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
