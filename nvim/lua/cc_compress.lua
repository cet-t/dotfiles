-- Algorithmic context compression for codecompanion.nvim
-- Patches Chat.submit to trim messages before each API call.
local M = {}

local defaults = {
	max_messages = 20,   -- system 以外の最大保持メッセージ数
	max_chars    = 3000, -- 1 メッセージの最大文字数
	tool_max_chars = 500, -- ツール出力の最大文字数
}

---@param content string
---@param limit integer
---@return string
local function truncate(content, limit)
	if #content <= limit then return content end
	return content:sub(1, limit) .. "\n…[省略 " .. (#content - limit) .. " 文字]"
end

---@param messages table
---@param opts table
local function compress(messages, opts)
	-- 1. 長いメッセージを切り詰め
	for _, msg in ipairs(messages) do
		if type(msg.content) == "string" then
			local limit = (msg.role == "tool") and opts.tool_max_chars or opts.max_chars
			msg.content = truncate(msg.content, limit)
		end
	end

	-- 2. system 以外が max_messages を超えたら古いものを捨てる
	local system, other = {}, {}
	for _, msg in ipairs(messages) do
		if msg.role == "system" then
			table.insert(system, msg)
		else
			table.insert(other, msg)
		end
	end

	if #other > opts.max_messages then
		local keep = vim.list_slice(other, #other - opts.max_messages + 1)
		-- messages テーブルを in-place で更新
		for k in pairs(messages) do messages[k] = nil end
		for _, msg in ipairs(system) do table.insert(messages, msg) end
		for _, msg in ipairs(keep) do table.insert(messages, msg) end
	end
end

function M.setup(opts)
	opts = vim.tbl_extend("force", defaults, opts or {})

	local Chat = require("codecompanion.interactions.chat")

	-- 二重パッチ防止
	if Chat._cc_compress_patched then return end
	Chat._cc_compress_patched = true

	local original = Chat.submit
	Chat.submit = function(self, ...)
		if self.messages then
			compress(self.messages, opts)
		end
		return original(self, ...)
	end
end

return M
