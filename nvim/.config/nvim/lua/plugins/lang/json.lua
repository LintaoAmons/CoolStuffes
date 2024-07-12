local jq_query = function()
  local sys = require("util.base.sys")
  local editor = require("util.editor")

  vim.ui.input({ prompt = 'Query pattern, e.g. `.[] | .["@message"].message`' }, function(pattern)
    local absPath = editor.buf.read.get_buf_abs_path()
    local stdout, _, stderr = sys.run_sync({ "jq", pattern, absPath }, ".")
    local result = stdout or stderr
    editor.split_and_write(result, { vertical = true, ft = "json" })
  end)
end
vim.keymap.set({ "n", "v" }, "rq", jq_query)

local function menu_item_routine(func, context)
  vim.api.nvim_set_current_buf(context.buffer)
  vim.api.nvim_set_current_win(context.window)
  vim.api.nvim_win_close(context.menu_window, true)
  vim.api.nvim_buf_delete(context.menu_buffer, {})
  func()
end

return {
  {
    dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
    opts = function(_, opts)
      local new_item = {
        cmd = "jq_query",
        ft = { "json" },
        callback = function(context)
          menu_item_routine(jq_query, context)
        end,
      }
      opts.add_menu_items = opts.add_menu_items or {}
      table.insert(opts.add_menu_items, new_item)
    end,
  },
  -- treesitter syntax hightlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "json", "jsonc" })
      end
    end,
  },

  -- format
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "jq" },
      },
    },
  },

  -- mason lsp,debugger install
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
  },
}
