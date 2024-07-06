vim.keymap.set("n", "mg", "<cmd>" .. "BookmarksGotoRecent" .. "<cr>")
vim.keymap.set("n", "mm", "<cmd>" .. "BookmarksMark" .. "<cr>")
vim.keymap.set("n", "ma", "<cmd>" .. "BookmarksCommands" .. "<cr>")
vim.keymap.set("n", "mo", "<cmd>" .. "BookmarksGoto" .. "<cr>")

return {
  {
    -- "LintaoAmons/bookmarks.nvim",
    event = "VeryLazy",
    dir = "/Volumes/t7ex/Documents/oatnil/beta/bookmarks.nvim",
    -- branch = "dev",
    config = function()
      require("bookmarks").setup({
        json_db_path = vim.fn.stdpath("config") .. "/bookmarks.db.json",
        signs = {
          mark = {
            icon = "󰃁",
            color = "red",
          },
        },
      })
    end,
  },
}
