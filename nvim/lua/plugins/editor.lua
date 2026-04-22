return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = { path_display = { "truncate" } },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      -- install parsers (skips already-installed)
      require("nvim-treesitter.install").install({
        "lua", "rust", "toml", "markdown", "bash", "json",
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "BufReadPre",
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Error Lens: inline diagnostics on same line
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_source = true,
          throttle = 20,
          softwrap = 30,
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },

  -- Trouble: diagnostics panel
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<CR>",                  desc = "Location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>",                   desc = "Quickfix list" },
    },
    opts = { use_diagnostic_signs = true },
  },
}
