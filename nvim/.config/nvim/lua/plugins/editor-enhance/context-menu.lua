---@param popup_content string[]
---@return {buf: integer, win: integer}
local function menu_popup_window(popup_content)
  local popup_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(popup_buf, 0, -1, false, popup_content)
  local width = vim.fn.strdisplaywidth(table.concat(popup_content, "\n"))
  local height = #popup_content

  local opts = {
    relative = "cursor",
    row = 0,
    col = 0,
    width = width + 1,
    height = height,
    style = "minimal",
    border = "single",
    title = "ContextMenu.",
  }

  local win = vim.api.nvim_open_win(popup_buf, true, opts)
  return {
    buf = popup_buf,
    win = win,
  }
end

local function quit_after_action(func, win_number)
  func()
  vim.api.nvim_win_close(win_number, true)
end

local function trigger_context_menu()
  local created = menu_popup_window({ "run_test", "run_as_cmd" })

  -- create local buffer shortcuts
  vim.keymap.set({ "v", "n" }, "q", function()
    vim.api.nvim_win_close(created.win, true)
  end, {
    noremap = true,
    silent = true,
    nowait = true,
    buffer = created.buf,
  })

  vim.keymap.set({ "v", "n" }, "<CR>", function()
    quit_after_action(function()
      local line = vim.api.nvim_get_current_line()
      if not line or line == "" then
        return
      elseif line == "run_test" then
        return require("neotest").run.run()
      end
    end, created.win)
  end, {
    noremap = true,
    silent = true,
    nowait = true,
    buffer = created.buf,
  })

  vim.keymap.set({ "v", "n" }, "g?", function()
    vim.print("<q> quit; <CR> trigger action under cursor")
  end, {
    noremap = true,
    silent = true,
    nowait = true,
    buffer = created.buf,
  })
end

vim.keymap.set({ "v", "n" }, "<C-k><C-k>", trigger_context_menu, {})

return {}
