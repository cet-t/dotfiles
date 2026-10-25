vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- preserved from old config
map("n", "qq", "<cmd>qall!<CR>", { silent = true, desc = "Quit all" })

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
map({ "n", "v", "i" }, "<leader>;", ":", { desc = "Enter command mode" })
map({ "n", "t" }, "<c-\\>", "<c-\\><c-n>")

-- oil.code
if vim.g.vscode then
	local vscode = require("vscode")
	local map = vim.keymap.set
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
		pattern = { "*" },
		callback = function()
			map("n", "-", function()
				vscode.action("oil-code.open")
			end)
		end,
	})

	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "oil" },
		callback = function()
			map("n", "-", function()
				vscode.action("oil-code.openParent")
			end)
			map("n", "_", function()
				vscode.action("oil-code.openCwd")
			end)
			map("n", "<C-;>", function()
				vscode.action("oil-code.select")
			end)
			map("n", "<C-t>", function()
				vscode.action("oil-code.selectTab")
			end)
			map("n", "<C-l>", function()
				vscode.action("oil-code.refresh")
			end)
			map("n", "`", function()
				vscode.action("oil-code.cd")
			end)
			map("n", "gd", function()
				vscode.action("oil-code.toggleDetails")
			end)
		end,
	})
end
