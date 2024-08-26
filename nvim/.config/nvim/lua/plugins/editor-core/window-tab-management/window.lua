local function split_vertically()
  local cmd = function()
    if vim.bo.buftype == "terminal" then
      local Terminal = require("toggleterm.terminal").Terminal
      Terminal:new({}):toggle()
    else
      vim.cmd("rightbelow vsplit")
    end
  end
  vim.keymap.set("n", "<leader>wl", cmd)
  vim.api.nvim_create_user_command("SplitVertically", cmd, {})
end
split_vertically()

local function split_horizontally()
  local cmd = "split"
  vim.api.nvim_create_user_command("SplitHorizontally", cmd, {})
end
split_horizontally()

local function close_window_or_buffer()
  local closeWindowOrBuffer = function()
    local isOk, _ = pcall(vim.cmd, "close")

    if not isOk then
      vim.cmd("bd")
    end
  end
  vim.keymap.set("n", "<M-w>", closeWindowOrBuffer)
end
close_window_or_buffer()

local maxmise_windows = function()
  require("util.editor").window.close_all_other_windows({
    "filesystem", -- neo-tree
    "Trouble",
    "term",
  })
end
vim.keymap.set("n", "<leader>wo", maxmise_windows)

local function maxmise_windows_all()
  local cmd = function()
    require("util.editor").window.close_all_other_windows({})
  end
  vim.keymap.set("n", "<leader>wO", cmd)
end
maxmise_windows_all()

local popup_window = {
  cmd = function()
    local api = vim.api

    local buf = api.nvim_create_buf(false, true)

    local opts = {
      style = "minimal",
      relative = "editor",
      height = api.nvim_get_option("lines") - 2,
      width = api.nvim_get_option("columns") - 3,
      title = "Popup",
      row = 2,
      col = 3,
      border = "rounded",
      zindex = 20,
    }

    -- Create the floating window with the current buffer
    api.nvim_open_win(buf, true, opts)

    -- Set the buffer's modifiable option to true
    api.nvim_buf_set_option(buf, "modifiable", true)
  end,
  actions = function(cmd)
    vim.api.nvim_create_user_command("PopupWindow", cmd, {})
  end,
}
popup_window.actions(popup_window.cmd)

local open_in_popup_window = {
  cmd = function()
    popup_window.cmd()
    require("telescope").extensions.smart_open.smart_open({
      cwd_only = true,
      filename_first = false,
    })
  end,
  actions = function(cmd)
    vim.keymap.set("n", "<M-C-p>", cmd)
    vim.api.nvim_create_user_command("OpenInPopupWindow", cmd, {})
  end,
}
open_in_popup_window.actions(open_in_popup_window.cmd)

local function maxmise_windows_as_popup()
  local cmd = function()
    local api = vim.api

    -- Get the current buffer
    local current_buf = api.nvim_get_current_buf()

    -- Get the editor's dimensions
    local win_width = api.nvim_get_option("columns")
    local win_height = api.nvim_get_option("lines")

    -- Define the floating window options
    local opts = {
      style = "minimal",
      relative = "editor",
      height = win_height - 2,
      width = win_width - 3,
      row = 2,
      col = 3,
      border = "rounded",
    }

    -- Create the floating window with the current buffer
    api.nvim_open_win(current_buf, true, opts)

    -- Set the buffer's modifiable option to true
    api.nvim_buf_set_option(current_buf, "modifiable", true)
  end
  vim.keymap.set("n", "<leader>wp", cmd)
  vim.api.nvim_create_user_command("MaxmiseWindowsAsPopup", cmd, {})
end
maxmise_windows_as_popup()

  --stylua: ignore start
  vim.keymap.set("n", "<C-h>", "<cmd>" .. "TmuxNavigateLeft" .. "<cr>")
  vim.keymap.set("n", "<C-l>", "<cmd>" .. "TmuxNavigateRight" .. "<cr>")
  vim.keymap.set("n", "<C-j>", "<cmd>" .. "TmuxNavigateDown" .. "<cr>")
  vim.keymap.set("n", "<C-k>", "<cmd>" .. "TmuxNavigateUp" .. "<cr>")

  local function resize_window()
    vim.keymap.set( "n", "<C-M-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
    vim.keymap.set( "n", "<C-M-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
    vim.keymap.set("n", "<C-M-j>", "<cmd>resize -5<cr>", { desc = "Increase window height" })
    vim.keymap.set("n", "<C-M-k>", "<cmd>resize +5<cr>", { desc = "Decrease window height" })
  end
  resize_window()
