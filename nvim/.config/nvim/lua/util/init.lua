local M = {}

---@filename string
---@return string
function M.ReadFileAsString(filename)
	return table.concat(vim.fn.readfile(filename), "\n")
end

function M.ReplacePattern(str, pattern, replacement)
	return string.gsub(str, pattern, replacement)
end

-- TODO: deprecated function.
M.getFiletype = function()
	return vim.bo.ft
end

---@param cmd string
---@return string|nil
---@deprecated use run_sync in util.base.sys module
function M.Call_sys_cmd(cmd)
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	-- TODO: get the error msg after failed to exec a command
	return result
end

-- TODO: deprecated
-- Use the function in sys
---@param content string
function M.copy_to_system_clipboard(content)
	local copy_cmd = "pbcopy"
	-- Copy the absolute path to the clipboard
	if vim.fn.has("mac") or vim.fn.has("macunix") then
		copy_cmd = "pbcopy"
	elseif vim.fn.has("win32") or vim.fn.has("win64") then
		copy_cmd = "clip"
	elseif vim.fn.has("unix") then
		copy_cmd = "xclip -selection clipboard"
	else
		print("Unsupported operating system")
		return
	end

	vim.fn.system(copy_cmd, content)
end

-- TODO: use the utli in editor
function M.ExitCurrentMode()
	local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)
end

return M
