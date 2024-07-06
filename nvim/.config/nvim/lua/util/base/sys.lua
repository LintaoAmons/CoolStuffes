local Job = require("plenary.job")

---@param cmd string[]
---@param cwd string
---@return table
---@return unknown
---@return table
local run_sync = function(cmd, cwd)
  if type(cmd) ~= "table" then
    print("cmd has to be a table")
    return {}, nil, {}
  end
  local command = table.remove(cmd, 1)
  local stderr = {}
  local stdout, ret = Job:new({
    command = command,
    args = cmd,
    cwd = cwd,
    on_stderr = function(_, data)
      table.insert(stderr, data)
    end,
  }):sync()
  return stdout, ret, stderr
end

---@param content string
local copy_to_system_clipboard = function(content)
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

---@class runOpts
---@field header string

---run command in a job and print the output to the buffer
---@param cmd string commands to run
---@param buf_nr number buffer number
---@param opts runOpts options
---@return number returns the job id
local run_async = function(cmd, buf_nr, opts)
  -- print the prompt header
  local header = {}
  if opts and opts.header then
    header = vim.split(opts.header, "\n")
    table.insert(header, "----------------------------------------")
    vim.api.nvim_buf_set_lines(buf_nr, 0, -1, false, header)
  end

  vim.api.nvim_buf_set_lines(buf_nr, 0, -1, false, header)

  local line = vim.tbl_count(header) + 1
  local words = {}

  -- start the async job
  return vim.fn.jobstart(cmd, {
    on_stdout = function(_, data, _)
      for i, token in ipairs(data) do
        if i > 1 then -- if returned data array has more than one element, a line break occured.
          line = line + 1
          words = {}
        end
        table.insert(words, token)
        vim.api.nvim_buf_set_lines(buf_nr, line, line + 1, false, { table.concat(words, "") })
      end
    end,
  })
end

---@class Sys
local Sys = {
  copy_to_system_clipboard = copy_to_system_clipboard,
  run_sync = run_sync,
  run_async = run_async,
}

return Sys
