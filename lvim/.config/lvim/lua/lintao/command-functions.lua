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

function M.LeapJump()
  require("leap").leap {
    target_windows = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    ),
  }
end

function M.MaximiseBuffer()
  -- Get the current buffer number
  local current_bufnr = vim.api.nvim_get_current_buf()

  -- Create a new tab and switch to it
  vim.api.nvim_command('tabnew')

  -- Get the new tab's buffer number
  local new_bufnr = vim.api.nvim_get_current_buf()

  -- Copy the contents of the current buffer to the new buffer
  vim.api.nvim_buf_set_lines(new_bufnr, 0, -1, false, vim.api.nvim_buf_get_lines(current_bufnr, 0, -1, false))

  -- Set the file type of the new buffer to match the current buffer
  vim.api.nvim_buf_set_option(new_bufnr, 'filetype', vim.api.nvim_buf_get_option(current_bufnr, 'filetype'))

  -- Set the modified flag of the new buffer to match the current buffer
  vim.api.nvim_buf_set_option(new_bufnr, 'modified', vim.api.nvim_buf_get_option(current_bufnr, 'modified'))

  -- Switch back to the original buffer in the new tab
  vim.api.nvim_set_current_buf(current_bufnr)
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

local function contains_marker_file(path)
  local marker_files = { ".git", ".gitignore" } -- list of marker files
  for _, file in ipairs(marker_files) do
    local full_path = path .. "/" .. file
    if vim.fn.filereadable(full_path) == 1 or vim.fn.isdirectory(full_path) == 1 then
      return true
    end
  end
  return false
end

local function is_homedir(path)
  local home_dir = vim.loop.os_homedir()
  return path == home_dir
end

---@return string|nil
local function find_project_path()
  for i = 1, 30, 1 do
    local dir = vim.fn.expand("%:p" .. string.rep(":h", i))
    print(dir)
    if contains_marker_file(dir) then
      return dir
    end
    if is_homedir(dir) then
      return print("didn't found project_path")
    end
  end
  return print("excide the max depth")
end

---@return string
function M.copyProjectDir()
  copyToSystemClipboard(find_project_path())
end

function M.CopyBufRelativePath()
  local buf_path = vim.fn.expand("%:p")
  local project_path = find_project_path() or ""
  local r = string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
  copyToSystemClipboard(r)
end

function M.CopyBufRelativeDirPath()
  local buf_path = vim.fn.expand("%:p:h")
  local project_path = find_project_path() or ""
  local r = string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
  copyToSystemClipboard(r)
end

---@param cmd string
---@return string|nil
local function call_sys_cmd(cmd)
  local handle = io.popen(cmd)
  local result = handle:read("*a")
  handle:close()
  return result
end

-- https://gitlab.com/jrop/dotfiles/-/blob/master/.config/nvim/lua/my/utils.lua#L13
---@return string
local function buf_vtext()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

local function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function replace_selected_text_with_clipboard()
  vim.cmd([[normal! gv"_dP]])
end

local function perform_cmd_to_selected_text(cmdFunc)
  local selectedText = buf_vtext()
  local output = call_sys_cmd(cmdFunc(selectedText))
  copyToSystemClipboard(trim(output))
  replace_selected_text_with_clipboard()
end

function M.toCamelCase()
  perform_cmd_to_selected_text(function(selectedText)
    return 'toolbox formatConvert toCamelCase "' .. selectedText .. '"'
  end)
end

function M.toConstantCase()
  perform_cmd_to_selected_text(function(selectedText)
    return 'toolbox formatConvert toConstantCase "' .. selectedText .. '"'
  end)
end

function M.toKebabCase()
  perform_cmd_to_selected_text(function(selectedText)
    return 'toolbox formatConvert ToKebabCase "' .. selectedText .. '"'
  end)
end

function M.toSnakeCase()
    perform_cmd_to_selected_text(function(selectedText)
    return 'toolbox formatConvert toSnakeCase "' .. selectedText .. '"'
  end)
end

return M
