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
          cmd = "Test",
          action = {
            type = "sub_cmds",
            sub_cmds = {
              {
                cmd = "Run Current File",
                action = {
                  type = "callback",
                  callback = function(_)
                    require("neotest").run.run(vim.fn.expand("%"))
                  end,
                },
              },
              {
                cmd = "Run Nearest",
                action = {
                  type = "callback",
                  callback = function(_)
                    require("neotest").run.run()
                  end,
                },
              },
              -- {
              --   cmd = "Debug Nearest",
              --   action = {
              --     type = "callback",
              --     callback = function(_)
              --       require("neotest").run.run({strategy = "dap"})
              --     end,
              --   },
              -- },
              {
                cmd = "Run Last",
                action = {
                  type = "callback",
                  callback = function(_)
                    require("neotest").run.run_last()
                  end,
                },
              },
              {
                cmd = "Run Suite",
                action = {
                  type = "callback",
                  callback = function(_)
                    require("neotest").run.run({ suite = true })
                  end,
                },
              },
              {
                cmd = "Stop Nearest",
                action = {
                  type = "callback",
                  callback = function(_)
                    require("neotest").run.stop()
                  end,
                },
              },
              {
                cmd = "Attach Nearest",
                action = {
                  type = "callback",
                  callback = function(_)
                    require("neotest").run.attach()
                  end,
                },
              },
              {
                cmd = "Output Panel",
                action = {
                  type = "sub_cmds",
                  sub_cmds = {
                    {
                      cmd = "Open",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").output_panel.open()
                        end,
                      },
                    },
                    {
                      cmd = "Close",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").output_panel.close()
                        end,
                      },
                    },
                    {
                      cmd = "Toggle",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").output_panel.toggle()
                        end,
                      },
                    },
                    {
                      cmd = "Clear",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").output_panel.clear()
                        end,
                      },
                    },
                  },
                },
              },
              {
                cmd = "Watch",
                action = {
                  type = "sub_cmds",
                  sub_cmds = {
                    {
                      cmd = "Toggle Current File",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").watch.toggle(vim.fn.expand("%"))
                        end,
                      },
                    },
                    {
                      cmd = "Stop All",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").watch.stop()
                        end,
                      },
                    },
                  },
                },
              },
              {
                cmd = "Summary",
                action = {
                  type = "sub_cmds",
                  sub_cmds = {
                    {
                      cmd = "Open",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").summary.open()
                        end,
                      },
                    },
                    {
                      cmd = "Close",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").summary.close()
                        end,
                      },
                    },
                    {
                      cmd = "Toggle",
                      action = {
                        type = "callback",
                        callback = function(_)
                          require("neotest").summary.toggle()
                        end,
                      },
                    },
                  },
                },
              },
            },
          },
        },
      },
    })
  end,
}
