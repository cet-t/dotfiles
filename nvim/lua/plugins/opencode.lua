return {
	{
		"nickjvandyke/opencode.nvim",
		version = "*",
		dependencies = {
			{
				"folke/snacks.nvim",
				opts = {
					input = {},
					picker = {
						actions = {
							opencode_send = function(...)
								return require("opencode").snacks_picker_send(...)
							end,
						},
						win = {
							input = {
								keys = {
									["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
								},
							},
						},
					},
				},
			},
		},
		config = function()
			vim.g.opencode_opts = {}

			vim.o.autoread = true

			local map = vim.keymap.set

			map({ "n", "t" }, "<leader>ot", function()
				require("opencode").toggle()
			end, { desc = "Toggle OpenCode" })

			map({ "n", "x" }, "<leader>oa", function()
				require("opencode").ask("@this: ", { submit = true })
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

			map("n", "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "OpenCode: scroll up" })

			map("n", "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "OpenCode: scroll down" })
		end,
	},
}
