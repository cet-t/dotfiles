return {
  -- formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      { "<leader>cf", function() require("conform").format({ async = true }) end, desc = "Format file" },
    },
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
        lua = { "stylua" },
        toml = { "taplo" },
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
      { "<leader>th", desc = "Toggle horizontal terminal" },
    },
    config = function()
      require("toggleterm").setup({
        size = 15,
        shade_terminals = true,
        direction = "float",
        float_opts = { border = "curved" },
      })

      local Terminal = require("toggleterm.terminal").Terminal

      -- floating
      local float_term = Terminal:new({ direction = "float", hidden = true })
      vim.keymap.set({ "n", "t" }, "<C-\\>", function() float_term:toggle() end, { desc = "Toggle float terminal" })

      -- horizontal bottom pane
      local horiz_term = Terminal:new({ direction = "horizontal", size = 15, hidden = true })
      vim.keymap.set({ "n", "t" }, "<leader>th", function() horiz_term:toggle() end, { desc = "Toggle horizontal terminal" })
    end,
  },

  -- Claude Code
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeContinue", "ClaudeCodeDiff" },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Claude Code" },
      { "<leader>ar", "<cmd>ClaudeCodeContinue<CR>", desc = "Claude Code (resume)" },
    },
    opts = {
      window = {
        position = "right",
        width = 0.4,
      },
    },
  },
}
