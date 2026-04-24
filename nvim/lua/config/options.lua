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

-- One Dark palette
-- green=#98c379  blue=#61afef  pink=#c678dd  cyan=#56b6c2  red=#e06c75

local cursor_hl_map = {
	n = "CursorNormal",
	i = "CursorInsert",
	v = "CursorVisual",
	V = "CursorVisual",
	["\22"] = "CursorVisual",
	R = "CursorReplace",
	c = "CursorNormal",
	t = "CursorInsert",
}

local function hl_to_hex(group)
	local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
	local bg = hl.bg
	if not bg then return nil end
	return ("#%06x"):format(bg)
end

local function set_terminal_cursor(color)
	io.write(("\027]12;%s\027\\"):format(color))
	io.flush()
end

vim.api.nvim_create_autocmd("ModeChanged", {
	callback = function()
		local hl = cursor_hl_map[vim.fn.mode()] or "CursorNormal"
		local color = hl_to_hex(hl)
		if color then set_terminal_cursor(color) end
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		io.write("\027]112\027\\")
		io.flush()
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "CursorNormal",  { bg = "#98c379" }) -- green
		vim.api.nvim_set_hl(0, "CursorInsert",  { bg = "#61afef" }) -- blue
		vim.api.nvim_set_hl(0, "CursorVisual",  { bg = "#c678dd" }) -- pink
		vim.api.nvim_set_hl(0, "CursorReplace", { bg = "#e06c75" }) -- red
	end,
})
vim.cmd("doautocmd ColorScheme")
