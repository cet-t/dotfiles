return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "InsertEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("minuet").setup({
				provider = "openai_compatible",
				provider_options = {
					openai_compatible = {
						model = "grok-3-mini-fast",
						end_point = "https://api.x.ai/v1/chat/completions",
						api_key = "XAI_API_KEY",
						name = "Grok",
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
