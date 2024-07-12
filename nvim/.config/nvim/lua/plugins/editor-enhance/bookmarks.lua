vim.keymap.set("n", "mg", "<cmd>" .. "BookmarksGotoRecent" .. "<cr>")
vim.keymap.set("n", "mm", "<cmd>" .. "BookmarksMark" .. "<cr>")
vim.keymap.set("n", "ma", "<cmd>" .. "BookmarksCommands" .. "<cr>")
vim.keymap.set("n", "mo", "<cmd>" .. "BookmarksGoto" .. "<cr>")

return {
  {
    "LintaoAmons/bookmarks.nvim",
    branch = "dev",
    event = "VeryLazy",
    -- dir = "/Volumes/t7ex/Documents/oatnil/beta/bookmarks.nvim",
    dependencies = {
      { "nvim-neo-tree/neo-tree.nvim" },
      { "ibhagwan/fzf-lua" },
    },
    config = function()
      require("bookmarks").setup({
        json_db_path = vim.fn.stdpath("data") .. "/bookmarks.db.json",
        signs = {
          mark = {
            icon = "󰃁",
            color = "red",
          },
        },
        hooks = {
          {
            callback = function(bookmark, projects)
              local project_path

              for _, p in ipairs(projects) do
                if p.name == bookmark.location.project_name then
                  project_path = p.path
                end
              end
              if project_path then
                vim.cmd("cd " .. project_path)
              end
            end,
          },
        },
      })
    end,
  },
}
