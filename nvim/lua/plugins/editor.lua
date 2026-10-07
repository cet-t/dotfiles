return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
			{ "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
		},
		opts = {
			defaults = { file_icons = true },
			winopts = { preview = { default = "bat" } },
			grep = {
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096",
			},
		},
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			local ensure_installed = {
				"lua",
				"rust",
				"toml",
				"markdown",
				"markdown_inline",
				"bash",
				"json",
				"yaml",
				"c",
				"cpp",
				"zig",
				"c_sharp",
				"python",
				"go",
				"regex",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
			}

			require("nvim-treesitter").install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"lua",
					"rust",
					"toml",
					"markdown",
					"bash",
					"json",
					"yaml",
					"c",
					"cpp",
					"zig",
					"cs",
					"python",
					"go",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
				},
				callback = function(ev)
					vim.treesitter.start(ev.buf)
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})

			require("nvim-treesitter-textobjects").setup({
				select = { lookahead = true },
				move = { set_jumps = true },
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")
			local swap = require("nvim-treesitter-textobjects.swap")
			local function map(mode, keys, fn, desc)
				vim.keymap.set(mode, keys, fn, { desc = desc })
			end

			map({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer")
			end, "Select outer function")
			map({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner")
			end, "Select inner function")
			map({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer")
			end, "Select outer class")
			map({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner")
			end, "Select inner class")
			map({ "x", "o" }, "aa", function()
				select.select_textobject("@parameter.outer")
			end, "Select outer parameter")
			map({ "x", "o" }, "ia", function()
				select.select_textobject("@parameter.inner")
			end, "Select inner parameter")
			map({ "x", "o" }, "al", function()
				select.select_textobject("@loop.outer")
			end, "Select outer loop")
			map({ "x", "o" }, "il", function()
				select.select_textobject("@loop.inner")
			end, "Select inner loop")
			map({ "x", "o" }, "ab", function()
				select.select_textobject("@block.outer")
			end, "Select outer block")
			map({ "x", "o" }, "ib", function()
				select.select_textobject("@block.inner")
			end, "Select inner block")

			map({ "n", "x", "o" }, "]f", function()
				move.goto_next_start({ "@function.outer" })
			end, "Next function start")
			map({ "n", "x", "o" }, "]c", function()
				move.goto_next_start({ "@class.outer" })
			end, "Next class start")
			map({ "n", "x", "o" }, "]F", function()
				move.goto_next_end({ "@function.outer" })
			end, "Next function end")
			map({ "n", "x", "o" }, "]C", function()
				move.goto_next_end({ "@class.outer" })
			end, "Next class end")
			map({ "n", "x", "o" }, "[f", function()
				move.goto_previous_start({ "@function.outer" })
			end, "Previous function start")
			map({ "n", "x", "o" }, "[c", function()
				move.goto_previous_start({ "@class.outer" })
			end, "Previous class start")
			map({ "n", "x", "o" }, "[F", function()
				move.goto_previous_end({ "@function.outer" })
			end, "Previous function end")
			map({ "n", "x", "o" }, "[C", function()
				move.goto_previous_end({ "@class.outer" })
			end, "Previous class end")

			map("n", "<leader>sn", function()
				swap.swap_next("@parameter.inner")
			end, "Swap next parameter")
			map("n", "<leader>sp", function()
				swap.swap_previous("@parameter.inner")
			end, "Swap previous parameter")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		opts = {
			max_lines = 3,
			trim_scope = "outer",
		},
	},

	{
		"terryma/vim-expand-region",
		keys = {
			{ "+", "<Plug>(expand_region_expand)", mode = { "n", "v" }, desc = "Expand region" },
			{ "_", "<Plug>(expand_region_shrink)", mode = { "v" }, desc = "Shrink region" },
		},
	},

	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		opts = {},
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
			},
			current_line_blame = false,
		},
		keys = {
			{ "<leader>gb", "<cmd>Gitsigns blame_line<CR>", desc = "Git blame line" },
			{ "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame" },
		},
	},

	{
		"diogo464/hotreload.nvim",
		opts = {}, -- Uses fs_event watchers by default
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},

	{
		"mrjones2014/smart-splits.nvim",
		event = "VeryLazy",
		config = function()
			local s = require("smart-splits")
			-- resize
			vim.keymap.set("n", "<leader>wk", s.resize_up, { desc = "Resize up" })
			vim.keymap.set("n", "<leader>wj", s.resize_down, { desc = "Resize down" })
			vim.keymap.set("n", "<leader>wh", s.resize_left, { desc = "Resize left" })
			vim.keymap.set("n", "<leader>wl", s.resize_right, { desc = "Resize right" })
			vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equalize windows" })
			-- window move
			vim.keymap.set({ "n", "t" }, "<C-Left>", "<C-w>h", { desc = "Move to left window" })
			vim.keymap.set({ "n", "t" }, "<C-Down>", "<C-w>j", { desc = "Move to lower window" })
			vim.keymap.set({ "n", "t" }, "<C-Up>", "<C-w>k", { desc = "Move to upper window" })
			vim.keymap.set({ "n", "t" }, "<C-Right>", "<C-w>l", { desc = "Move to right window" })
		end,
	},

	-- Error Lens: inline diagnostics on same line
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "modern",
				options = {
					show_source = true,
					throttle = 20,
					softwrap = 30,
				},
			})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "BufReadPost",
		keys = {
			{
				"zO",
				function()
					require("ufo").openFold()
				end,
				desc = "Open current fold",
			},
			{
				"zOA",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"zC",
				function()
					require("ufo").closeFold()
				end,
				desc = "Close current fold",
			},
			{
				"zCA",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
			{
				"zP",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				desc = "Peek fold",
			},
		},
		opts = {
			provider_selector = function()
				return { "lsp", "indent" }
			end,
			fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ("  %d lines"):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						table.insert(newVirtText, { chunkText, chunk[2] })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "Comment" })
				return newVirtText
			end,
		},
	},

	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown", "markdown_inline" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			preview = {
				modes = { "n", "no", "c" },
				hybrid_modes = { "i", "v" },
			},
		},
	},
}
