---@alias Position {row: number, col: number}

---comment
---@return Position
local get_cursor_position = function()
  local _, row, col, _ = unpack(vim.fn.getpos("."))
  return { row, col }
end

---@return {row: number, col: number}
local get_visual_selection_start_position = function()
  local _, row, col, _ = unpack(vim.fn.getpos("'<"))
  return { row, col }
end

local function replaceSelectedTextWithClipboard()
  vim.cmd([[normal! gv"_dP]])
end

local function exit_current_mode()
  local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
  vim.api.nvim_feedkeys(esc, "x", false)
end

---@return Position[]
local function get_selected_positions()
  -- this will exit visual mode
  -- use 'gv' to reselect the text
  local _, csrow, cscol, cerow, cecol
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "" then
    -- if we are in visual mode use the live position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
    if mode == "V" then
      -- visual line doesn't provide columns
      cscol, cecol = 0, 999
    end
    exit_current_mode()
  else
    -- otherwise, use the last known visual position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end
  -- swap vars if needed
  if cerow < csrow then
    csrow, cerow = cerow, csrow
  end
  if cecol < cscol then
    cscol, cecol = cecol, cscol
  end

  return {
    { row = csrow, col = cscol },
    { row = cerow, col = cecol },
  }
end

-- Copy from https://github.com/ibhagwan/fzf-lua
local function getSelectedText()
  -- this will exit visual mode
  -- use 'gv' to reselect the text
  local _, csrow, cscol, cerow, cecol
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "" then
    -- if we are in visual mode use the live position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
    if mode == "V" then
      -- visual line doesn't provide columns
      cscol, cecol = 0, 999
    end
    exit_current_mode()
  else
    -- otherwise, use the last known visual position
    _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  end
  -- swap vars if needed
  if cerow < csrow then
    csrow, cerow = cerow, csrow
  end
  if cecol < cscol then
    cscol, cecol = cecol, cscol
  end
  local lines = vim.fn.getline(csrow, cerow)
  local tableUtil = require("util.base.table")
  local n = tableUtil.table_length(lines)
  if n <= 0 then
    return ""
  end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)
  return table.concat(lines, "\n")
end

---@return {row: number, col: number}
local get_visual_selection_end_position = function()
  local _, row, col, _ = unpack(vim.fn.getpos("'>"))
  return { row, col }
end

local ESC_FEEDKEY = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
--- @return string
local get_visual_lines = function(bufnr)
  vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)
  vim.api.nvim_feedkeys("gv", "x", false)
  vim.api.nvim_feedkeys(ESC_FEEDKEY, "n", true)

  local start_row, start_col = unpack(vim.api.nvim_buf_get_mark(bufnr, "<"))
  local end_row, end_col = unpack(vim.api.nvim_buf_get_mark(bufnr, ">"))
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)

  if start_row == 0 then
    lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    start_row = 1
    start_col = 0
    end_row = #lines
    end_col = #lines[#lines]
  end

  start_col = start_col + 1
  end_col = math.min(end_col, #lines[#lines] - 1) + 1

  lines[#lines] = lines[#lines]:sub(1, end_col)
  lines[1] = lines[1]:sub(start_col)

  return table.concat(lines, "\n")
end

local countWindows = function()
  -- Get the current tabpage ID
  local tabpage_id = vim.api.nvim_get_current_tabpage()

  -- Get the list of window handles for all windows in the current tabpage
  local windows = vim.api.nvim_tabpage_list_wins(tabpage_id)

  -- Return the count of windows
  return #windows
end

---@alias SplitMode "virtical"  | "horizontal"
---@param splitMode SplitMode
local splitWindow = function(splitMode)
  if splitMode == "virtical" then
    vim.api.nvim_exec2("wincmd v", { output = false })
  elseif splitMode == "horizontal" then
    vim.api.nvim_exec2("wincmd s", { output = false })
  else
    vim.print("Not supported mode")
  end
end

---@return string
local function get_current_line()
  return vim.api.nvim_get_current_line()
end

local function is_homedir(path)
  local home_dir = vim.loop.os_homedir()
  return path == home_dir
end

local function contains_marker_file(path)
  local marker_files = vim.g.easy_command_project_root_dir_marker_files or { ".git", ".gitignore" } -- list of marker files
  for _, file in ipairs(marker_files) do
    local full_path = path .. "/" .. file
    if vim.fn.filereadable(full_path) == 1 or vim.fn.isdirectory(full_path) == 1 then
      return true
    end
  end
  return false
end

---@param ignore_patterns string[]|nil
local function close_all_other_windows(ignore_patterns)
  -- Get the current window ID
  local current_win = vim.api.nvim_get_current_win()

  -- Get the list of all window IDs
  local windows = vim.api.nvim_list_wins()

  -- Function to check if the buffer name matches any pattern in the list
  local function should_ignore(buf_name)
    for _, pattern in
      ipairs(ignore_patterns or {
        "filesystem", -- neo-tree
        "Trouble",
      })
    do
      if string.find(buf_name, pattern) then
        return true
      end
    end
    return false
  end

  -- Close all windows except the current one and those matching ignore patterns
  for _, win in ipairs(windows) do
    if win ~= current_win then
      -- Get the buffer ID for the window
      local buf = vim.api.nvim_win_get_buf(win)
      -- Get the name of the buffer
      local buf_name = vim.api.nvim_buf_get_name(buf)
      -- Check if the buffer's name should be ignored
      if not should_ignore(buf_name) then
        vim.api.nvim_win_close(win, false)
      end
    end
  end
end

---@return string
local function get_buf_name()
  local bufnr = vim.api.nvim_get_current_buf()
  return vim.api.nvim_buf_get_name(bufnr)
end

local get_buf_filetype = function()
  return vim.bo.ft
end

--- Get current buffer size
---@return {width: number, height: number}
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

local function get_buf_filename()
  return vim.fn.expand("%:t")
end

local function get_buf_abs_path()
  return vim.fn.expand("%:p")
end

---@return string
local function get_buf_abs_dir_path()
  return vim.fn.expand("%:p:h")
end

---@return string|nil
local function find_project_path()
  for i = 1, 30, 1 do
    local dir = vim.fn.expand("%:p" .. string.rep(":h", i))
    if contains_marker_file(dir) then
      return dir
    end
    if is_homedir(dir) then
      return nil
    end
  end
  return nil
end

local function find_project_name()
  local project_path = find_project_path()
  if project_path then
    return vim.fn.fnamemodify(project_path, ":t")
  end
  return ""
end

local function get_buf_relative_path()
  local buf_path = get_buf_abs_path()
  local project_path = find_project_path() or ""
  return string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
end

local function get_buf_relative_dir_path()
  local buf_path = get_buf_abs_path()
  local project_path = find_project_path() or ""
  return string.sub(buf_path, string.len(project_path) + 2, string.len(buf_path))
end

-- Puts text at cursor, in any mode.
--
-- Compare |:put| and |p| which are always linewise.
--
-- Attributes: ~
--     not allowed when |textlock| is active
--
-- Parameters: ~
--   • {lines}   |readfile()|-style list of lines. |channel-lines|
--   • {type}    Edit behavior: any |getregtype()| result, or:
--               • "b" |blockwise-visual| mode (may include width, e.g. "b3")
--               • "c" |charwise| mode
--               • "l" |linewise| mode
--               • "" guess by contents, see |setreg()|
--   • {after}   If true insert after cursor (like |p|), or before (like
--               |P|).
--   • {follow}  If true place cursor at end of inserted text.
--- @param lines string[]
--- @param type string
--- @param after boolean
--- @param follow boolean
local function put_lines(lines, type, after, follow)
  vim.api.nvim_put(lines, type, after, follow)
end

--- Create a new horizontal splitted buffer
--- and write the content into the buffer
---@param content string[]
---@param opts {vertical: boolean, ft?: string}
local function split_and_write(content, opts)
  if opts.vertical then
    vim.cmd("vnew")
  else
    vim.cmd("new")
  end

  -- Get the current buffer
  local buf = vim.api.nvim_get_current_buf()

  -- Clear the buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  -- Write the content into the buffer
  put_lines(content, "", true, true)

  -- Set the buffer as unmodified
  vim.cmd("setlocal nomodified")
  if opts.ft then
    vim.bo.ft = opts.ft
  end
end

---@param terminal_chan number
---@param term_cmd_text string
local send_to_terminal_buf = function(terminal_chan, term_cmd_text)
  vim.api.nvim_chan_send(terminal_chan, term_cmd_text .. "\n")
end

--- Get the channel of the first terminal
--- channel structure can be find at
--- https://neovim.io/doc/user/api.html#nvim_get_chan_info()
---@return any?
local function get_first_terminal()
  local terminal_chans = {}
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan["mode"] == "terminal" and chan["pty"] ~= "" then
      table.insert(terminal_chans, chan)
    end
  end
  table.sort(terminal_chans, function(left, right)
    return left["buffer"] < right["buffer"]
  end)
  if #terminal_chans == 0 then
    return nil
  end
  return terminal_chans[1]
end

--- Check if the channel's buffer visible
--- You can get the buffer number by `vim.api.nvim_list_chans()`
---@param channel_buffer_number number this is the chan buffer number not chan id
---@return boolean
local function is_visible(channel_buffer_number)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == channel_buffer_number then
      return true
    end
  end
  return false
end

---@return any?
local function get_first_visible_terminal()
  local terminal_chans = {}
  for _, chan in pairs(vim.api.nvim_list_chans()) do
    if chan["mode"] == "terminal" and chan["pty"] ~= "" and is_visible(chan.buffer) then
      table.insert(terminal_chans, chan)
    end
  end
  table.sort(terminal_chans, function(left, right)
    return left["buffer"] < right["buffer"]
  end)
  if #terminal_chans == 0 then
    return nil
  end
  return terminal_chans[1]
end

---@param popup_content string[]
---@return {buf: integer, win: integer}
local function new_popup_window(popup_content)
  local popup_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, popup_content)
  vim.api.nvim_buf_set_option(popup_buf, "filetype", "sh")
  local width = vim.fn.strdisplaywidth(table.concat(popup_content, "\n"))
  local height = #popup_content

  local opts = {
    relative = "cursor",
    row = 0,
    col = 0,
    width = width + 4,
    height = height + 2,
    style = "minimal",
    border = "single",
  }

  local win = vim.api.nvim_open_win(popup_buf, true, opts)
  return {
    buf = popup_buf,
    win = win,
  }
end

local M = {
  selections = {
    getCursorPosition = getCursorPosition,
    get_positions = get_selected_positions,
    get_visual_selection_start_position = get_visual_selection_start_position,
    get_visual_selection_end_position = get_visual_selection_end_position,
    getVisualLines = get_visual_lines,
    get_selected = getSelectedText,
  },
  tab = {
    countWindows = countWindows,
  },
  window = {
    close_all_other_windows = close_all_other_windows,
    splitWindow = splitWindow,
    new_popup_window = new_popup_window,
  },
  buf = {
    read = {
      get_buf_name = get_buf_name,
      get_buf_filetype = get_buf_filetype,
      get_buf_size = get_buf_size,
      get_buf_filename = get_buf_filename,
      get_buf_abs_path = get_buf_abs_path,
      get_buf_abs_dir_path = get_buf_abs_dir_path,
      get_buf_relative_path = get_buf_relative_path,
      get_buf_relative_dir_path = get_buf_relative_dir_path,
      get_cursor_position = get_cursor_position,
      get_current_line = get_current_line,
      get_selected = getSelectedText,
      is_visible = is_visible,
    },
    write = {
      put_lines = put_lines,
      send_to_terminal_buf = send_to_terminal_buf,
    },
  },
  get_first_terminal = get_first_terminal,
  get_first_visible_terminal = get_first_visible_terminal,
  split_and_write = split_and_write,
  find_project_path = find_project_path,
  find_project_name = find_project_name,
  replaceSelectedTextWithClipboard = replaceSelectedTextWithClipboard,
  -- TODO: refactor into selections group
  getSelectedText = getSelectedText,
  get_current_line = get_current_line,
}

return M
