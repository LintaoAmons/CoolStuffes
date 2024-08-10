local editor = require("util.editor")
local log = require("util.log")

local disposible_terminal = function()
  local current_config = vim.g.lintao_config or {}
  local bufnr = current_config.tmp_term_bufnr
  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    vim.cmd("split") -- TODO: check if the window is opened or not
    vim.api.nvim_set_current_buf(bufnr)
    vim.api.nvim_feedkeys("i", "n", true)
  else
    vim.cmd("split")
    vim.cmd("terminal")
    vim.api.nvim_feedkeys("i", "n", true)
    current_config.tmp_term_bufnr = vim.api.nvim_get_current_buf()
    vim.g.lintao_config = current_config
  end
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

local run_current_line = require("features.terminal-and-run").run_current_line
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
vim.api.nvim_create_user_command("RunSelected", run_selected, {});

(function()
  local function cd_to_buffer_location()
    local editor = require("util.editor")
    local cmd = "cd " .. editor.buf.read.get_buf_abs_dir_path()
    local terminal = editor.get_first_visible_terminal()
    if not terminal then
      return log.error("No visible terminal found")
    end
    editor.buf.write.send_to_terminal_buf(terminal.id, cmd)
  end
  vim.keymap.set({ "n", "v" }, "<leader>si", cd_to_buffer_location)
end)();

(function()
  local a = require("features.terminal-and-run").run_file
  vim.keymap.set({ "n", "v" }, "<M-r>", a)
  vim.api.nvim_create_user_command("RunFile", a, {})
end)()

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
  vim.keymap.set("t", "<M-w>", [[<Cmd>wincmd c<CR>]], opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
  {
    dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
    opts = function()
      require("context-menu").setup({
        menu_items = {
          {
            cmd = "Run File",
            not_ft = { "markdown" },
            action = {
              type = "callback",
              callback = function(context)
                if context.ft == "lua" then
                  return vim.cmd([[source %]])
                elseif context.ft == "javascript" then
                  local stdout = vim.fn.system("node " .. vim.fn.expand("%:p"))
                  local result = require("util.base.strings").split_into_lines(stdout)
                  require("util.editor").split_and_write(result, {})
                elseif context.ft == "typescript" then
                  local stdout = vim.fn.system("ts-node " .. vim.fn.expand("%:p"))
                  local result = require("util.base.strings").split_into_lines(stdout)
                  require("util.editor").split_and_write(result, {})
                end
              end,
            },
          },
        },
      })
    end,
  },

  -- {
  --   "michaelb/sniprun",
  --   branch = "master",
  --
  --   build = "sh install.sh",
  --   -- do 'sh install.sh 1' if you want to force compile locally
  --   -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
  --
  --   config = function()
  --     require("sniprun").setup({
  --       -- your options
  --     })
  --   end,
  -- },
}
