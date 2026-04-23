return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",        -- Alt+l で全体確定
          accept_word = "<M-w>",   -- Alt+w で単語確定
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-e>",
        },
      },
      panel = { enabled = false },
      filetypes = { ["*"] = true },
    },
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
