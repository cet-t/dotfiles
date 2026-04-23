vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- preserved from old config
map("n", "qq", ":qall!<CR>", { silent = true, desc = "Quit all" })

-- file tree
map("n", "<C-n>",     "<cmd>Neotree toggle<CR>", { silent = true, desc = "Toggle file tree" })
map("n", "<leader>e", function()
  local ft = vim.bo.filetype
  if ft == "neo-tree" then
    vim.cmd("wincmd p")
  else
    vim.cmd("Neotree focus")
  end
end, { silent = true, desc = "Toggle neo-tree focus" })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>",  { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>",    { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>",  { desc = "Help tags" })

-- diagnostics
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- buffer nav
map("n", "<S-h>", "<cmd>bprev<CR>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search" })

map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
