return {
  {
    "stevearc/conform.nvim",

    opts = function(_, opts)
      opts.formatters_by_ft["sh"] = { "shfmt" }
    end,
  },
  {
    dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
    opts = function(_, opts)
      require("context-menu").setup({
        menu_items = {
          {
            cmd = "Run As CMD",
            ft = { "sh" },
            callback = function(context)
              local stdout = vim.fn.system(context.line)
              local lines = require("util.base.strings").split_into_lines(stdout)
              vim.api.nvim_set_current_buf(context.buffer)
              vim.api.nvim_put(lines, "l", true, true)
            end,
          },
        },
      })
    end,
  },
}
