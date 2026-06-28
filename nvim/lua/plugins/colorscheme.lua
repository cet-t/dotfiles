return {
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({ style = "darker", transparent = true })
			vim.cmd.colorscheme("onedark")

			local function make_transparent()
				local groups = {
					"Normal", "NormalNC", "SignColumn", "NormalFloat",
					"FloatBorder", "EndOfBuffer",
				}
				for _, g in ipairs(groups) do
					vim.api.nvim_set_hl(0, g, { bg = "NONE", ctermbg = "NONE" })
				end

				-- lualine
				for _, hl in ipairs(vim.fn.getcompletion("lualine_", "highlight")) do
					local ok, info = pcall(vim.api.nvim_get_hl, 0, { name = hl, link = false })
					if ok and type(info) == "table" then
						info.bg = nil
						info.ctermbg = nil
						vim.api.nvim_set_hl(0, hl, info)
					end
				end

				-- bufferline
				for _, hl in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
					local ok, info = pcall(vim.api.nvim_get_hl, 0, { name = hl, link = false })
					if ok and type(info) == "table" then
						info.bg = nil
						info.ctermbg = nil
						vim.api.nvim_set_hl(0, hl, info)
					end
				end
			end

			make_transparent()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = make_transparent })
		end,
	},
}
