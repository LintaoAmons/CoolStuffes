return {
  {
    "FabijanZulj/blame.nvim",
    event = 'VeryLazy',
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
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("diffview").setup({
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
