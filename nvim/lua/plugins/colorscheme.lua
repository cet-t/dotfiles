return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "darker" })
			vim.cmd.colorscheme("onedark")
		end,
	},

	{
		"xiyaowong/transparent.nvim",
		lazy = false,
		config = function()
			require("transparent").setup({
				extra_groups = {
					"BufferLineTabClose",
					"BufferLineBufferSelected",
					"BufferLineFill",
					"BufferLineBackground",
					"BufferLineSeparator",
					"BufferLineIndicatorSelected",
				},
			})
			require("transparent").clear_prefix("BufferLine")
		end,
	},
}
