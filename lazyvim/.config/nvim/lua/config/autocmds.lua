-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- TODO: Put inside easy-commands Plugin
local function save()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! write")
  end)
end

function ToggleAutoSave()
  local flag = vim.g.easy_command_auto_save or false
  if flag then
    vim.g.easy_command_auto_save = false
    vim.api.nvim_del_augroup_by_name("AutoSave")
  else
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
    vim.g.easy_command_auto_save = true
  end
end

ToggleAutoSave()

-- HACK: don't wrap in markdown
-- vim.api.nvim_create_augroup("lazyvim_wrap_spell", {clear = true})

vim.cmd([[ autocmd BufNewFile,BufRead *.hurl set filetype=hurl ]])

vim.cmd([[ autocmd BufNewFile,BufRead *.mdx set filetype=md ]])

local function set_ime(args)
  if args.event:match("Enter$") then
    vim.g.neovide_input_ime = true
  else
    vim.g.neovide_input_ime = false
  end
end

local ime_input = vim.api.nvim_create_augroup("ime_input", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
  group = ime_input,
  pattern = "*",
  callback = set_ime,
})

vim.api.nvim_create_autocmd({ "CmdlineEnter", "CmdlineLeave" }, {
  group = ime_input,
  pattern = "[/\\?]",
  callback = set_ime,
})
