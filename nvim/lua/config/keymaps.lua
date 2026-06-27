vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- preserved from old config
map("n", "qq", ":qall!<CR>", { silent = true, desc = "Quit all" })


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
