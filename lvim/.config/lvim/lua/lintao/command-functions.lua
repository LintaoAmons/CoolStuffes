local M = {}

-- Put all dependences here

-- from: https://www.reddit.com/r/neovim/comments/13l0p0p/leapnvim_meets_vimilluminate/
-- function M.search_ref()
--   local ref = require("illuminate.reference").buf_get_references(vim.api.nvim_get_current_buf())
--   if not ref or #ref == 0 then
--     return false
--   end

--   local targets = {}
--   for _, v in pairs(ref) do
--     table.insert(targets, {
--       pos = { v[1][1] + 1, v[1][2] + 1 },
--     })
--   end

--   require("leap").leap({ targets = targets, target_windows = { vim.api.nvim_get_current_win() } })

--   return true
-- end

function M.MaximiseBuffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local winnr = vim.api.nvim_get_current_win()

  -- Get the current buffer name
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  -- Create a new tab
  vim.api.nvim_command('tabnew')

  -- Set the current window's buffer to the buffer we want to open
  vim.api.nvim_win_set_buf(winnr, bufnr)

  -- Optionally, if you want to set the buffer name in the new tab to the same as the old one
  vim.api.nvim_buf_set_name(bufnr, bufname)
end

function M.GoToTestFile()
  local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')

  if buf_ft == 'go' then
    vim.api.nvim_command('GoAlt')
  else
    vim.notify("Not implemented yet")
  end
end

function M.closeWindowOrBuffer()
  local isOk, _ = pcall(vim.cmd, "close")

  if not isOk then vim.cmd "bd" end
end

local function copyToSystemClipboard(content)
  local copy_cmd = 'pbcopy'
  -- Copy the absolute path to the clipboard
  if vim.fn.has('mac') or vim.fn.has('macunix') then
    copy_cmd = 'pbcopy'
  elseif vim.fn.has('win32') or vim.fn.has('win64') then
    copy_cmd = 'clip'
  elseif vim.fn.has('unix') then
    copy_cmd = 'xclip -selection clipboard'
  else
    print('Unsupported operating system')
    return
  end

  vim.fn.system(copy_cmd, content)
end

function M.copyBufferAbsolutePath()
  local buffer_path = vim.fn.expand('%:p')
  copyToSystemClipboard(buffer_path)
end

function M.copyBufferDirectoryPath()
  local buffer_dir_path = vim.fn.expand('%:p:h')
  copyToSystemClipboard(buffer_dir_path)
end

function M.stashAndCommit()
  vim.api.nvim_command('Git add .')
  vim.api.nvim_command('Git commit')
end

return M
