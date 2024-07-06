
---@param msg string
local function notifyErr(msg)
  vim.notify("easy-comands.nvim: \n" .. msg, vim.log.levels.ERROR, { title = "easy-commands.nvim" })
end

return {
  error = notifyErr,
}
