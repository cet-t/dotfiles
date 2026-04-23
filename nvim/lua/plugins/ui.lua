return {
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "famiu/bufdelete.nvim",
    keys = {
      { "<leader>q", "<cmd>Bdelete<CR>", desc = "Close buffer" },
    },
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" },
        },
        show_buffer_close_icons = true,
        separator_style = "slant",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      window = { width = 30 },
      filesystem = {
        filtered_items = { visible = false, hide_dotfiles = false },
        follow_current_file = { enabled = true },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "onedark",
        globalstatus = true,
      },
      sections = {
        lualine_c = { { "filename", path = 1 } },
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        hover = { enabled = true },
        signature = { enabled = true },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },
}
