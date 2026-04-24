local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.clipboard = "unnamed"
opt.number = true
opt.relativenumber = true
opt.hlsearch = true
opt.smartindent = true
opt.laststatus = 3
opt.wildmenu = true
opt.ruler = true
opt.history = 9999
opt.encoding = "utf8"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.scrolloff = 8
opt.wrap = false
opt.splitright = true
opt.splitbelow = true

-- カーソル：モードごとに色とシェイプを変える
opt.guicursor = {
  "n-c:block-CursorNormal",
  "i-ci:ver25-CursorInsert",
  "v-ve:block-CursorVisual",
  "r-cr:hor20-CursorReplace",
}

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "CursorNormal",  { bg = "#61afef" }) -- blue  (Normal)
    vim.api.nvim_set_hl(0, "CursorInsert",  { bg = "#98c379" }) -- green (Insert)
    vim.api.nvim_set_hl(0, "CursorVisual",  { bg = "#e5c07b" }) -- yellow (Visual)
    vim.api.nvim_set_hl(0, "CursorReplace", { bg = "#e06c75" }) -- red   (Replace)
  end,
})
vim.cmd("doautocmd ColorScheme")
