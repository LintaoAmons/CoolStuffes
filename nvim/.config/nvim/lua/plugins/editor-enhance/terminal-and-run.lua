local log = require("util.log")

local run_current_line = require("features.terminal-and-run").run_current_line
vim.keymap.set({ "n", "v" }, "<leader>rl", run_current_line)
vim.api.nvim_create_user_command("RunCurrentLine", run_current_line, {})

local run_selected = function()
  local editor = require("util.editor")
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

local function cd_to_buffer_location()
  local editor = require("util.editor")
  local cmd = "cd " .. editor.buf.read.get_buf_abs_dir_path()
  local terminal = editor.get_first_visible_terminal()
  if not terminal then
    return log.error("No visible terminal found")
  end
  editor.buf.write.send_to_terminal_buf(terminal.id, cmd)
  vim.cmd([[TmuxNavigateDown]])
  vim.cmd([[norm! i]])
end
vim.keymap.set({ "n", "v" }, "<leader>si", cd_to_buffer_location)

local function run_current_file()
  local cmd = function()
    if vim.bo.ft == "javascript" then
      vim.cmd([[!node %]])
    elseif vim.bo.ft == "html" then
      vim.cmd([[!open %]])
    end
  end

  vim.keymap.set({ "n", "v" }, "<M-r>", cmd)
  vim.api.nvim_create_user_command("RunFile", cmd, {})
end
run_current_file()

-- local function popup_terminal()
--   require("toggleterm.terminal").Terminal
--     :new({
--       dir = "git_dir",
--       direction = "float",
--       float_opts = {
--         border = "double",
--       },
--       -- function to run on opening the terminal
--       on_open = function(term)
--         vim.cmd("startinsert!")
--         vim.api.nvim_buf_set_keymap(
--           term.bufnr,
--           "n",
--           "q",
--           "<cmd>close<CR>",
--           { noremap = true, silent = true }
--         )
--         vim.keymap.set({ "n", "v" }, "<M-w>", function()
--           term:shutdown()
--         end, { noremap = true, silent = true, buffer = term.bufnr })
--       end,
--       -- function to run on closing the terminal
--       on_close = function(term)
--         vim.api.nvim_buf_delete(term.bufnr, { force = true })
--         vim.cmd("startinsert!")
--       end,
--     })
--     :toggle()
-- end
--
-- REF: https://github.com/AstroNvim/astrocommunity/blob/d64d788e163f6d759e8a1adf4281dd5dd2841a78/lua/astrocommunity/terminal-integration/toggleterm-manager-nvim/init.lua
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<ESC>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-t>", [[<C-\><C-n><C-t>]], opts)
  vim.keymap.set("t", "<M-w>", [[<Cmd>wincmd c<CR>]], opts)
  vim.keymap.set("t", "<M-3>", [[<C-\><C-n><M-3>]], opts) -- toggle disposable terminal
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
            order = 1,
            not_ft = { "markdown", "toggleterm" },
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
          {
            cmd = "Close Terminal",
            order = 1,
            ft = { "toggleterm" },
            action = {
              type = "callback",
              callback = function(context)
                vim.cmd("bd!")
              end,
            },
          },
          -- {
          --   cmd = "Popup Terminal",
          --   order = 1,
          --   not_ft = { "markdown" },
          --   action = {
          --     type = "callback",
          --     callback = function(_)
          --       popup_terminal()
          --     end,
          --   },
          -- },
        },
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 20,
      })
      -- init base terminal
      local new_base_term = function()
        return require("toggleterm.terminal").Terminal:new({
          display_name = "Base",
          count = 1,
          direction = "horizontal",
          dir = vim.fn.expand("%:p:h"),
          auto_scroll = true, -- automatically scroll to the bottom on terminal output
        })
      end
      new_base_term():spawn()

      local function toggle_term()
        local all = require("toggleterm.terminal").get_all(true)
        if #all == 0 then
          new_base_term():toggle()
        else
          vim.cmd("ToggleTermToggleAll")
        end
      end
      vim.keymap.set("n", "<M-3>", toggle_term)

      vim.keymap.set("n", "<leader>sl", ":ToggleTermSendCurrentLine<cr>")
      vim.keymap.set("v", "<leader>sk", ":ToggleTermSendVisualSelection<cr>")
    end,
  },
}
