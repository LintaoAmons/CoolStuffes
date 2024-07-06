local editor = require("util.editor")
local log = require("util.log")

local disposible_terminal = function()
  vim.cmd("split")
  vim.cmd("terminal")
  vim.api.nvim_feedkeys("i", "n", true) -- 在普通模式下发送字符 'a'
end
vim.keymap.set("n", "<leader>ii", disposible_terminal)
vim.api.nvim_create_user_command("DisposibleTerminal", disposible_terminal, {})

local send_selected_to_terminal_and_run = function()
  local terminal = editor.get_first_visible_terminal()
  if not terminal then
    return log.error("No visible terminal found")
  end
  local selected = editor.getSelectedText()
  editor.buf.write.send_to_terminal_buf(terminal.id, selected)
end
vim.keymap.set("n", "<leader>sk", send_selected_to_terminal_and_run)
vim.api.nvim_create_user_command(
  "SendSelectedToTerminalAndRun",
  send_selected_to_terminal_and_run,
  { range = true }
)

local send_line_to_terminal_and_run = function()
  local line = editor.buf.read.get_current_line()
  local terminal = editor.get_first_visible_terminal()
  if not terminal then
    return log.error("No visible terminal found")
  end
  editor.buf.write.send_to_terminal_buf(terminal.id, line)
  vim.notify("line sended to terminal " .. terminal.id)
end
vim.keymap.set({ "n", "v" }, "<leader>sl", send_line_to_terminal_and_run)
vim.api.nvim_create_user_command("SendLineToTerminalAndRun", send_line_to_terminal_and_run, {})

local run_current_line = function()
  local sys = require("util.base.sys")
  local stringUtil = require("util.base.strings")
  local currentLine = editor.buf.read.get_current_line()
  local stdout = vim.fn.system(currentLine)
  local result = stringUtil.split_into_lines(stdout)
  editor.buf.write.put_lines(result, "l", true, true)
  pcall(sys.copy_to_system_clipboard, stringUtil.join(result, "\n"))
end
vim.keymap.set({ "n", "v" }, "<leader>rl", run_current_line)
vim.api.nvim_create_user_command("RunCurrentLine", run_current_line, {})

local run_selected = function()
  local sys = require("util.base.sys")
  local stringUtil = require("util.base.strings")
  local selected = editor.buf.read.get_selected()
  local stdout, _, stderr = sys.run_sync(stringUtil.split_cmd_string(selected), ".")
  local result = stdout or stderr
  editor.buf.write.put_lines(result, "l", true, true)
  pcall(sys.copy_to_system_clipboard, stringUtil.join(result, "\n"))
end
vim.keymap.set({ "n", "v" }, "<leader>rk", run_selected)
vim.api.nvim_create_user_command("RunSelected", run_selected, {})

-- REF: https://github.com/AstroNvim/astrocommunity/blob/d64d788e163f6d759e8a1adf4281dd5dd2841a78/lua/astrocommunity/terminal-integration/toggleterm-manager-nvim/init.lua
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-t>", [[<C-\><C-n><C-t>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
  "ryanmsnyder/toggleterm-manager.nvim",
  dependencies = {
    "akinsho/nvim-toggleterm.lua",
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
  },
  config = function()
    local toggleterm_manager = require("toggleterm-manager")
    local actions = toggleterm_manager.actions

    toggleterm_manager.setup({
      mappings = {
        i = {
          ["<CR>"] = { action = actions.open_term, exit_on_action = true },
          ["<C-d>"] = { action = actions.delete_term, exit_on_action = false },
          ["<C-t>"] = { action = actions.toggle_term, exit_on_action = false },
        },
        n = {
          ["<CR>"] = { action = actions.create_and_name_term, exit_on_action = true },
          ["x"] = { action = actions.delete_term, exit_on_action = false },
        },
      },
    })
  end,
}
