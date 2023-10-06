return {
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },
  {
    "FabijanZulj/blame.nvim",
    event = "VeryLazy",
  },
  {
    "NeogitOrg/neogit",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    opts = {
      integrations = {
        diffview = true,
      },
      disable_insert_on_commit = "auto",
      commit_popup = {
        kind = "tab",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    -- dir = "/Users/lintao/Documents/oatnil/github-preview/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup({
        keymaps = {
          file_panel = {
            {
              "n",
              "c",
              function() -- TODO: pull requist
                vim.ui.input({ prompt = "Commit msg: " }, function(msg)
                  local sys = require("easy-commands.impl.util.base.sys")
                  sys.run_os_cmd({ "git", "commit", "-m", msg }, ".")
                  vim.api.nvim_command("tabclose")
                end)
              end,
              { desc = "git commit" },
            },
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
