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
