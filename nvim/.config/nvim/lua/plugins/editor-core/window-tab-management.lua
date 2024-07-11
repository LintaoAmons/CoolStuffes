(function()
  local split_vertically = function()
    require("util.editor").window.close_all_other_windows({
      "filesystem",
      "Trouble",
    })
    vim.cmd("rightbelow vsplit")
  end
  vim.keymap.set("n", "<leader>wl", split_vertically)
  vim.api.nvim_create_user_command("SplitVertically", split_vertically, {})
end)();

(function()
  local split_horizontally = "split"
  vim.api.nvim_create_user_command("SplitHorizontally", split_horizontally, {})
end)()

local tabNext = "tabnext"
vim.keymap.set("n", "tl", "<cmd>" .. tabNext .. "<cr>")

local tabPrevious = "tabprevious"
vim.keymap.set("n", "th", "<cmd>" .. tabPrevious .. "<cr>")

local tabClose = "tabclose"
vim.keymap.set("n", "tt", "<cmd>" .. tabClose .. "<cr>")

local closeWindowOrBuffer = function()
  local isOk, _ = pcall(vim.cmd, "close")

  if not isOk then
    vim.cmd("bd")
  end
end
vim.keymap.set("n", "<M-w>", closeWindowOrBuffer)

local maxmise_windows = function()
  require("util.editor").window.close_all_other_windows({
    "filesystem", -- neo-tree
    "Trouble",
  })
end
vim.keymap.set("n", "<leader>wo", maxmise_windows);

(function()
  local maxmise_windows_as_popup = function()
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
      height = win_height - 6,
      width = win_width - 10,
      row = 2,
      col = 3,
      border = "rounded",
    }

    -- Create the floating window with the current buffer
    api.nvim_open_win(current_buf, true, opts)

    -- Set the buffer's modifiable option to true
    api.nvim_buf_set_option(current_buf, "modifiable", true)
  end
  vim.keymap.set("n", "<leader>wp", maxmise_windows_as_popup)
  vim.api.nvim_create_user_command("MaxmiseWindowsAsPopup", maxmise_windows_as_popup, {})
end)()

vim.keymap.set("n", "<C-h>", "<cmd>" .. "TmuxNavigateLeft" .. "<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>" .. "TmuxNavigateRight" .. "<cr>")
vim.keymap.set("n", "<C-j>", "<cmd>" .. "TmuxNavigateDown" .. "<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>" .. "TmuxNavigateUp" .. "<cr>")

return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
}
