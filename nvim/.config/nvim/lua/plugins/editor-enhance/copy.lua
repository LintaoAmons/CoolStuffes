--- Returns the absolute path of the current file relative to the project root, and the current line and column.
--- @return string|nil
local function copy_line_ref()
  local current_file_dir = vim.fn.expand("%:p:h") -- '%:p:h' expands to the directory of the current file

  -- Find the .git directory starting from the current file's directory and moving upwards
  local git_dir = vim.fn.finddir(".git", current_file_dir .. ";")

  -- If a .git directory is found, get the project root
  if git_dir ~= "" then
    local project_root = vim.fn.fnamemodify(git_dir, ":p:h:h") -- Get the project root directory
    -- Get the absolute path of the current file
    local current_file_absolute = vim.fn.expand("%:p")

    -- Calculate the relative path from the project root to the current file
    local relative_path = string.sub(current_file_absolute, string.len(project_root) + 2)
    -- vim.print(git_dir)
    -- vim.print(current_file_absolute)
    -- vim.print(relative_path)

    -- Get the current line and column in the same line by unpacking the cursor position
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

    local line_ref = relative_path .. ":" .. line .. ":" .. col

    vim.fn.setreg("+", line_ref)
    -- Return the reference path, line, and column
    return line_ref
  else
    return nil -- Return nil if no .git directory is found
  end
end
vim.api.nvim_create_user_command("CopyLineRef", copy_line_ref, {})

local function copy_buf_name()
  local buf_name = vim.fn.expand("%:p:t")
  vim.print(buf_name)
  vim.fn.setreg("+", buf_name)
  return buf_name
end
vim.api.nvim_create_user_command("CopyBufName", copy_buf_name, {})

local function copy_buf_abs_path()
  local abs_path = require("util.editor").buf.read.get_buf_abs_path()
  vim.print(abs_path)
  vim.fn.setreg("+", abs_path)
  return abs_path
end
vim.api.nvim_create_user_command("CopyBufAbsPath", copy_buf_abs_path, {})


return {}
