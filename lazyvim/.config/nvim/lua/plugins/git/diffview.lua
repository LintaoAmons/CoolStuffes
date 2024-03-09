return {
  {
    "rbong/vim-flog",
    event = "VeryLazy",
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },

  {
    "FabijanZulj/blame.nvim",
    event = "VeryLazy",
  },

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
            ["<M-k>s"] = function()
              vim.ui.input({ prompt = "Stash msg: " }, function(msg)
                local Job = require("plenary.job")
                local stderr = {}
                Job:new({
                  command = "git",
                  args = { "stash", "-m", msg },
                  cwd = ".",
                  on_stderr = function(_, data)
                    table.insert(stderr, data)
                  end,
                }):sync()
              end)
            end,

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
                if #stderr == 0 then
                  vim.api.nvim_command("tabclose")
                else
                  vim.print(stderr[1])
                end
                --
                -- Get the commands module from neo-tree.sources.filesystem. Found here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/main/lua/neo-tree/sources/filesystem/commands.lua
                require("neo-tree.sources.filesystem.commands")
                  -- Call the refresh function found here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/2f2d08894bbc679d4d181604c16bb7079f646384/lua/neo-tree/sources/filesystem/commands.lua#L11-L13
                  .refresh(
                    -- Pull in the manager module. Found here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/2f2d08894bbc679d4d181604c16bb7079f646384/lua/neo-tree/sources/manager.lua
                    require("neo-tree.sources.manager")
                      -- Fetch the state of the "filesystem" source, feeding it to the filesystem refresh call since most everything in neo-tree
                      -- expects to get its state fed to it
                      .get_state("filesystem")
                  )
              end)
            end,

            ["C"] = "TODO: COMMIT and PUSH",
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
