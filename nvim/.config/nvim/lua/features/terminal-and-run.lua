local editor = require("util.editor")

local M = {}

function M.run_current_line()
  local sys = require("util.base.sys")
  local stringUtil = require("util.base.strings")
  local currentLine = editor.buf.read.get_current_line()
  local stdout = vim.fn.system(currentLine)
  local result = stringUtil.split_into_lines(stdout)
  editor.buf.write.put_lines(result, "l", true, true)
  pcall(sys.copy_to_system_clipboard, stringUtil.join(result, "\n"))
end

return M
