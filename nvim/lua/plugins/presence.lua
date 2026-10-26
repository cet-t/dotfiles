return {
	{
		"IogaMaster/neocord",
		lazy = false,
		opts = {
			auto_update = true,
			client_id = "1562452324000079952",
			logo = "penpen",
			logo_tooltip = "claude codex",
			main_image = "logo",
			editing_text = "%s をそれっぽく編集中",
			file_explorer_text = "コンテキスト検索中",
			reading_text = "%s を無断学習中",
			workspace_text = "%s を乗っ取り中",
			terminal_text = "適当にコマンド実行中",
			show_time = true,
			enable_line_number = 0,
		},
		config = function(_, opts)
			local utils = require("neocord.utils")
			utils.get_gui_info = function()
				local ok, chan = pcall(vim.api.nvim_get_chan_info, 1)
				local client = ok and chan.client or nil
				return client and client.type == "ui" and client.name or nil
			end
			require("neocord.filetypes.plugin_managers").lazy = nil
			require("neocord.filetypes.file_explorers").fyler_finder = "Fyler"
			local neocord = require("neocord")
			local is_win = vim.fn.has("win32") == 1
			local sep = is_win and "\\" or "/"
			neocord.get_current_buffer = function()
				local name = vim.api.nvim_buf_get_name(0)
				local fyler_dir = name:match("^fyler%-file://(.*)$")
				if fyler_dir then
					local dir = vim.fn.fnamemodify(fyler_dir ~= "" and fyler_dir or ".", ":p"):gsub("[/\\]+$", "")
					name = dir .. sep .. "Fyler"
				end
				if is_win and name:match("^%a:[/\\]") then
					name = name:gsub("/", "\\")
				end
				return name
			end
			neocord.get_project_name = function(self, dir)
				if not dir then
					return nil
				end
				local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
				if vim.v.shell_error ~= 0 or not out[1] or out[1] == "" then
					return nil
				end
				local path = is_win and out[1]:gsub("/", "\\") or out[1]
				return self.get_filename(path, self.os.path_separator), path
			end
			neocord.setup(opts)
		end,
	},
}
