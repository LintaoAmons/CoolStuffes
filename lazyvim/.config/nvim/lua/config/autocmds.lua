-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- HACK: Autosave
local function save()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! write")
  end)
end

vim.api.nvim_create_augroup("AutoSave", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    save()
  end,
  pattern = "*",
  group = "AutoSave",
})
