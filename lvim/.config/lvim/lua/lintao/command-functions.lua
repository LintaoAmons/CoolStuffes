local M = {}

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

local function stashAndCommit()
  vim.api.nvim_command('Git add .')
  vim.api.nvim_command('Git commit')
end
M.stashAndCommit = stashAndCommit

return M
