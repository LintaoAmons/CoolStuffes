return {
  { import = "plugins.editor-enhance.ai" },
  {
"LintaoAmons/context-menu.nvim",
    opts = function()
      require("context-menu").setup({
        close_menu = { "q", "<ESC>", "<M-l>" },
        menu_items = {
          {
            order = 1,
            cmd = "AI",
            keymap = "a",
            action = {
              type = "sub_cmds",
              sub_cmds = {
                {
                  order = 1,
                  keymap = "a",
                  cmd = "New",
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[GpChatNew]])
                    end,
                  },
                },
                {
                  order = 3,
                  keymap = "p",
                  cmd = "Append",
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[GpAppend]])
                    end,
                  },
                },
                {
                  order = 2,
                  cmd = "Find",
                  keymap = "f",
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[GpChatFinder]])
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
}
