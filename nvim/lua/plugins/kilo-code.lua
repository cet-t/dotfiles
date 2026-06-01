return {
	{
		"mikaoelitiana/kilo-code.nvim",
		cmd = { "KiloCodeOpen", "KiloCodeClose", "KiloCodeToggle", "KiloCodeInstall", "KiloCodeCheck" },
		keys = {
			{ "<leader>kt", "<cmd>KiloCodeToggle<CR>", desc = "Toggle KiloCode", mode = { "n", "t" } },
			{ "<leader>ko", "<cmd>KiloCodeOpen<CR>", desc = "Open KiloCode", mode = { "n", "t" } },
			{ "<leader>kc", "<cmd>KiloCodeClose<CR>", desc = "Close KiloCode", mode = { "n", "t" } },
			{ "<leader>ki", "<cmd>KiloCodeInstall<CR>", desc = "Install/Update KiloCode CLI", mode = "n" },
			{ "<leader>ks", "<cmd>KiloCodeCheck<CR>", desc = "Check KiloCode status", mode = "n" },
		},
		opts = {
			auto_install = false,
			file_watcher = { enabled = false },
		},
	},
}
