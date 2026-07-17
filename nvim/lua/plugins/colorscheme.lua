return {
	{
		"ayu-theme/ayu-vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.ayucolor = "dark"
			vim.cmd.colorscheme("ayu")
		end,
	},
}
