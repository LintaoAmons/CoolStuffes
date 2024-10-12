local group_name = "langHttp"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- Set indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group_name,
  pattern = {
    "*.http",
  },
  command = "setlocal ft=http",
})

return {
  {
    "LintaoAmons/context-menu.nvim",
    dependencies = {
      "mistweaverco/kulala.nvim",
    },
    opts = function()
      require("context-menu").setup({
        menu_items = {
          {
            cmd = "Send HTTP Request",
            fix = 1,
            ft = { "http" },
            action = {
              type = "callback",
              callback = function(_)
                require("kulala").run()
              end,
            },
          },
          {
            cmd = "HTTP",
            fix = 2,
            ft = { "http" },
            action = {
              type = "sub_cmds",
              sub_cmds = {
                {
                  cmd = "Re Run",
                  fix = 1,
                  action = {
                    type = "callback",
                    callback = function(_)
                      require("kulala").replay()
                    end,
                  },
                },
                {
                  cmd = "Copy Curl",
                  fix = 1,
                  action = {
                    type = "callback",
                    callback = function(_)
                      require("kulala").copy()
                    end,
                  },
                },
                {
                  cmd = "From Curl",
                  fix = 1,
                  action = {
                    type = "callback",
                    callback = function(_)
                      require("kulala").from_curl()
                    end,
                  },
                },
                {
                  cmd = "Set Env",
                  action = {
                    type = "callback",
                    callback = function(_)
                      require('kulala').set_selected_env()
                    end,
                  },
                },
                {
                  cmd = "Get Current Env",
                  action = {
                    type = "callback",
                    callback = function(_)
                      require('kulala').get_selected_env()
                    end,
                  },
                },
              },
            },
          },
        },
      })
    end,
  },

  -- HTTP REST-Client Interface
  {
    "mistweaverco/kulala.nvim",
    config = function()
      -- -- Setup is required, even if you don't pass any options
      require("kulala").setup({
        default_view = "headers_body",
      })
    end,
  },
}
