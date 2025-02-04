local gitStatus = "DiffviewOpen"
vim.keymap.set("n", "<M-0>", "<cmd>" .. gitStatus .. "<cr>")
vim.api.nvim_create_user_command("GitStatus", gitStatus, {})

return {
  
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      local action = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          view = {
            ["r"] = function()
              vim.cmd("GitResetHunk")
              vim.notify("Reset hunk")
              vim.cmd("DiffviewRefresh")
            end,
            ["gf"] = function()
              local diffview_tab = vim.api.nvim_get_current_tabpage()
              action.goto_file_edit()
              vim.api.nvim_command("tabclose " .. diffview_tab)
            end,
          },
          file_history_panel = {
            { "n", "fa", "g!=a", { remap = true } },
            { "n", "ff", "g!--", { remap = true } },
          },
          file_panel = {
            -- stash staged changes
            -- TODO: Add context menu
            -- ["<M-k>S"] = function()
            --   vim.ui.input({ prompt = "Stash msg: " }, function(msg)
            --     local Job = require("plenary.job")
            --     local stderr = {}
            --     Job:new({
            --       command = "git",
            --       args = { "stash", "-m", msg },
            --       cwd = ".",
            --       on_stderr = function(_, data)
            --         table.insert(stderr, data)
            --       end,
            --     }):sync()
            --   end)
            -- end,

            ["c"] = function()
              vim.ui.input({ prompt = "Commit msg: " }, function(msg)
                local Job = require("plenary.job")
                local stderr = {}
                Job:new({
                  command = "git",
                  args = { "commit", "-m", msg },
                  cwd = ".",
                  on_stderr = function(_, data)
                    table.insert(stderr, data)
                  end,
                }):sync()
              end)
            end,

            ["p"] = function()
              vim.notify("Start to push")
              local Job = require("plenary.job")
              local stderr = {}
              Job:new({
                command = "git",
                args = { "push" },
                cwd = ".",
                on_stdout = function(_, data)
                  vim.notify("Pushed to remote")
                end,
                on_stderr = function(_, data)
                  table.insert(stderr, data)
                end,
              }):start()
            end,
          },
        },
        view = {
          default = {
            winbar_info = true,
          },
          file_history = {
            winbar_info = true,
          },
        },
      })
    end,
  },
}
