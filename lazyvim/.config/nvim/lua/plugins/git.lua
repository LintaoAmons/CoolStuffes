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
          file_history_panel = {
            { "n", "fa", "g!=a", { remap = true } },
            { "n", "ff", "g!--", { remap = true } },
          },
          file_panel = {
            {
              "n",
              "c",
              function()
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
