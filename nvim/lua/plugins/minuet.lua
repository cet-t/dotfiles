return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "InsertEnter",
		config = function()
			require("minuet").setup({
				provider = "codestral",
				provider_options = {
					codestral = {
						model = "codestral-latest",
						api_key = "CODESTRAL_API_KEY",
						optional = {
							max_tokens = 256,
							stop = { "\n\n" },
						},
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
