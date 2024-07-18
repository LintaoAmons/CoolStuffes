local function save()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! write")
  end)
end

function ToggleAutoSave()
  local flag = vim.g.auto_save or false
  if flag then
    vim.g.auto_save = false
    vim.api.nvim_del_augroup_by_name("AutoSave")
  else
    vim.api.nvim_create_augroup("AutoSave", {
      clear = true,
    })
    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      callback = save,
      pattern = "*",
      group = "AutoSave",
    })
    vim.g.auto_save = true
  end
end

ToggleAutoSave()
vim.api.nvim_create_user_command("ToggleAutoSave", ToggleAutoSave, {})

return {}
