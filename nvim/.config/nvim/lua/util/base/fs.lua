local create_file = function(abspath)
  local open_mode = vim.loop.constants.O_CREAT
    + vim.loop.constants.O_WRONLY
    + vim.loop.constants.O_TRUNC
  local fd = vim.loop.fs_open(abspath, "w", open_mode)
  if not fd then
    vim.notify("create file failed")
  else
    vim.loop.fs_chmod(abspath, 420)
    vim.loop.fs_close(fd)
  end
end

local Fs = {
  create_file = create_file,
}

return Fs
