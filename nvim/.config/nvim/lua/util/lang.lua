local editor = require("easy-commands.impl.util.editor")

---@functionName string
local call_language_specific_func = function(functionName)
  require("easy-commands.impl.lang." .. editor.buf.read.get_buf_filetype())[functionName]()
  -- local ok, _ = pcall(require("easy-commands.impl.lang." .. editor.getFiletype())[functionName])
  -- if not ok then
  --   vim.notify("There's some error or may not be implemented yet for [" .. editor.getFiletype() .. "] type")
  -- end
end

local M = {
  call_language_specific_func = call_language_specific_func,
}

return M
