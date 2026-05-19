return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "InsertEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("minuet").setup({
				provider = "gemini",
				provider_options = {
					gemini = {
						model = "gemini-2.5-flash-preview-04-17",
						api_key = "GEMINI_API_KEY",
					},
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					keymap = {
						accept        = "<M-l>",
						accept_line   = "<M-w>",
						next          = "<M-]>",
						prev          = "<M-[>",
						dismiss       = "<C-e>",
					},
				},
			})
		end,
	},
}
