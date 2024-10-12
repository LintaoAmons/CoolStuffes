return {
  -- # Format
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft["sh"] = { "shfmt" }
      opts.formatters_by_ft["zsh"] = { "shfmt" }
    end,
  },
  {
"LintaoAmons/context-menu.nvim",
    opts = function(_, opts)
      require("context-menu").setup({
        menu_items = {
          {
            cmd = "RunCurrentLine",
            fix = 1,
            ft = { "sh" },
            action = {
              type = "callback",
              callback = function(context)
                local stdout = vim.fn.system(context.line)
                local lines = require("util.base.strings").split_into_lines(stdout)
                vim.api.nvim_set_current_buf(context.buffer)
                vim.api.nvim_put(lines, "l", true, true)
              end,
            },
          },
        },
      })
    end,
  },
}
