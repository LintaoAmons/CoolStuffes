--- Function to increment each character in the selected text, except blank characters (encode)
local function encode_selected_chars()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  -- Iterate through each line in the selected region
  for line_num = start_line, end_line do
    local line = vim.fn.getline(line_num)

    local col_start = (line_num == start_line) and start_col or 1
    local col_end = (line_num == end_line) and end_col or #line

    local new_line = line:sub(1, col_start - 1)

    -- Increment each character in the current line
    for col = col_start, col_end do
      local char = line:sub(col, col)
      if char and char ~= " " and char ~= "\t" then
        local new_char = string.char(char:byte() + 1)
        new_line = new_line .. new_char
      else
        new_line = new_line .. char
      end
    end

    new_line = new_line .. line:sub(col_end + 1)

    -- Replace the line in the buffer
    vim.fn.setline(line_num, new_line)
  end
end

--- Function to decrement each character in the selected text, except blank characters (decode)
local function decode_selected_chars()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_line = start_pos[2]
  local start_col = start_pos[3]
  local end_line = end_pos[2]
  local end_col = end_pos[3]

  -- Iterate through each line in the selected region
  for line_num = start_line, end_line do
    local line = vim.fn.getline(line_num)

    local col_start = (line_num == start_line) and start_col or 1
    local col_end = (line_num == end_line) and end_col or #line

    local new_line = line:sub(1, col_start - 1)

    -- Decrement each character in the current line
    for col = col_start, col_end do
      local char = line:sub(col, col)
      if char and char ~= " " and char ~= "\t" then
        local new_char = string.char(char:byte() - 1)
        new_line = new_line .. new_char
      else
        new_line = new_line .. char
      end
    end

    new_line = new_line .. line:sub(col_end + 1)

    -- Replace the line in the buffer
    vim.fn.setline(line_num, new_line)
  end
end

vim.keymap.set({ "n", "v" }, "<leader>ie", encode_selected_chars)
vim.keymap.set({ "n", "v" }, "<leader>id", decode_selected_chars)

-- Revised Explanation:
-- C-u in Keybinding:
-- :<C-u> clears any existing command-line input. This ensures a clean state before running the Lua function.
-- This is especially useful when mapping functions to visual mode keybindings because Vim could otherwise append the function call to any existing text on the command line, leading to errors.
-- vim.api.nvim_set_keymap("v", "<leader>ie", ":<c-u>lua encode_selected_chars()<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>id", ":<C-u>lua decode_selected_chars()<CR>", { noremap = true, silent = true })

return {}
