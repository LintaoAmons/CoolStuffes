return {
  "NeogitOrg/neogit",
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
}
