return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		dependencies = {
			{
				"folke/snacks.nvim",
				lazy = false,
				priority = 1000,
				opts = {
					input = {},
					picker = {},
				},
			},
		},
		config = function()
			vim.g.opencode_opts = {}

			vim.o.autoread = true

			local map = vim.keymap.set

			map({ "n", "t" }, "<leader>ot", function()
				require("opencode").ask()
			end, { desc = "Toggle OpenCode" })

			map({ "n", "x" }, "<leader>oa", function()
				require("opencode").prompt("@this: ")
			end, { desc = "OpenCode: ask about selection" })

			map({ "n", "x" }, "<leader>os", function()
				require("opencode").select()
			end, { desc = "OpenCode: select prompt" })

			map("n", "<leader>on", function()
				require("opencode").command("session.new")
			end, { desc = "OpenCode: new session" })

			map("n", "<leader>ou", function()
				require("opencode").command("session.undo")
			end, { desc = "OpenCode: undo" })

			map("n", "<leader>or", function()
				require("opencode").command("session.redo")
			end, { desc = "OpenCode: redo" })

			map({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "OpenCode: add range", expr = true })

			map("n", "<C-k>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "OpenCode: scroll up" })

			map("n", "<C-j>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "OpenCode: scroll down" })
		end,
	},
}
