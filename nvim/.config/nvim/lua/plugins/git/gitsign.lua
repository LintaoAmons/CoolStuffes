local prev_hunk = function()
  require("gitsigns").prev_hunk({ navigation_message = false })
  vim.cmd([[normal! zz]])
end
vim.keymap.set("n", "gk", prev_hunk)

local next_hunk = function()
  require("gitsigns").next_hunk({ navigation_message = false })
  vim.cmd([[normal! zz]])
end
vim.keymap.set("n", "gj", next_hunk)

return {
  {
    "LintaoAmons/context-menu.nvim",
    opts = function(_, opts)
      require("context-menu").setup({
        menu_items = {
          {
            cmd = "Git",
            keymap= "g",
            order = 85,
            action = {
              type = "sub_cmds",
              sub_cmds = {
                {
                  cmd = "Commit Log Diagram",
                  order = 86,
                  action = {
                    type = "callback",
                    callback = function(_)
                      require("gitgraph").draw({}, { all = true, max_count = 5000 })
                    end,
                  },
                },
                {
                  cmd = "Git :: Blame",
                  order = 85,
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[Gitsigns blame]])
                    end,
                  },
                },
                {
                  cmd = "Git :: Peek",
                  order = 80,
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[Gitsigns preview_hunk]])
                    end,
                  },
                },
                {
                  cmd = "Git :: Reset Hunk",
                  order = 81,
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[Gitsigns reset_hunk]])
                    end,
                  },
                },
                {
                  cmd = "Git :: Reset Buffer",
                  order = 82,
                  action = {
                    type = "callback",
                    callback = function(_)
                      vim.cmd([[Gitsigns reset_buffer]])
                    end,
                  },
                },
                {
                  cmd = "Git :: Diff Current Buffer",
                  order = 83,
                  action = {
                    type = "callback",
                    callback = function(_)
                      require("gitsigns").diffthis()
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
  -- git signs highlights text that has changed since the list
  -- git commit, and also lets you interactively stage & unstage
  -- hunks in a commit.
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
    },
  },
}
