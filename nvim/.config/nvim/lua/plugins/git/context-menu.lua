return {
  "LintaoAmons/context-menu.nvim",
  dependencies = {
    { "sindrets/diffview.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "isakbm/gitgraph.nvim" },
  },
  opts = function()
    require("context-menu").setup({
      menu_items = {
        {
          cmd = "Git",
          keymap = "g",
          order = 85,
          action = {
            type = "sub_cmds",
            sub_cmds = {
              {
                cmd = "Git Status",
                action = {
                  type = "callback",
                  callback = function(_)
                    vim.cmd([[DiffviewOpen]])
                  end,
                },
              },
              {
                cmd = "Branch History",
                action = {
                  type = "callback",
                  callback = function(_)
                    vim.cmd([[DiffviewFileHistory]])
                  end,
                },
              },
              {
                cmd = "Current File Commit History",
                action = {
                  type = "callback",
                  callback = function(_)
                    vim.cmd([[DiffviewFileHistory %]])
                  end,
                },
              },
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
}
