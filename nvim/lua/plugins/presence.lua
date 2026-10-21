return {
	{
		"IogaMaster/neocord",
		-- VeryLazy だと起動時のバッファの BufEnter を取りこぼすので即時ロード
		lazy = false,
		opts = {
			auto_update = true,
			-- 表示名 "ClaudeCodex" の自前 Discord アプリケーション (名前は Developer Portal で管理)
			client_id = "1562452324000079952",
			-- Developer Portal の Rich Presence Art Assets に登録したキー名
			logo = "penpen",
			logo_tooltip = "claude codex",
			main_image = "logo",
			editing_text = "Hallucinating %s",
			file_explorer_text = "Searching for context",
			reading_text = "Training on %s",
			workspace_text = "Taking over %s",
			show_time = true,
			-- 未指定 (nil) / false だと同一バッファの重複送信チェック (== 0) が効かず、Discord のレート制限に掛かる
			enable_line_number = 0,
		},
		config = function(_, opts)
			-- チャンネル1にクライアント情報が無いと get_gui_info が nil を index して落ちるので保護
			local utils = require("neocord.utils")
			utils.get_gui_info = function()
				local ok, chan = pcall(vim.api.nvim_get_chan_info, 1)
				local client = ok and chan.client or nil
				return client and client.type == "ui" and client.name or nil
			end
			-- :Lazy で "Managing plugins" に上書きされたまま戻らないので、lazy では直前の表示を維持する
			require("neocord.filetypes.plugin_managers").lazy = nil
			-- fyler (fyler-file://...) を file explorer として扱う
			require("neocord.filetypes.file_explorers").fyler_finder = "Fyler"
			local neocord = require("neocord")
			local is_win = vim.fn.has("win32") == 1
			local sep = is_win and "\\" or "/"
			neocord.get_current_buffer = function()
				local name = vim.api.nvim_buf_get_name(0)
				-- fyler-file://<dir> はディレクトリ配下のダミーパス "<dir>/Fyler" にして、
				-- neocord が親ディレクトリからプロジェクト名を引けるようにする
				-- (ファイル名部分は small_text になるので Discord の制約上 2 文字以上必要)
				local fyler_dir = name:match("^fyler%-file://(.*)$")
				if fyler_dir then
					local dir = vim.fn.fnamemodify(fyler_dir ~= "" and fyler_dir or ".", ":p"):gsub("[/\\]+$", "")
					name = dir .. sep .. "Fyler"
				end
				-- neocord は Windows で "\" 区切り前提のため、"D:/foo/bar.rs" のようなバッファ名だと
				-- ファイル名が nil になり何も送信されない。ドライブパスは "\" に正規化して渡す
				if is_win and name:match("^%a:[/\\]") then
					name = name:gsub("/", "\\")
				end
				return name
			end
			-- 本家は `cd "<dir>" && git ...` で調べるが、cmd.exe の cd は別ドライブへ移動しないので git -C を使う
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
