local function gitgraph()
  local cmd = function()
    require("gitgraph").draw({}, { all = true, max_count = 5000 })
  end
  vim.keymap.set("n", "<leader>gl", cmd, { desc = "new git graph" })
end
gitgraph()

return {
  "isakbm/gitgraph.nvim",
  dependencies = { "sindrets/diffview.nvim" },
  ---@type I.GGConfig
  opts = {
    symbols = {
      merge_commit = "M",
      commit = "*",
    },
    format = {
      timestamp = "%H:%M:%S %d-%m-%Y",
      fields = { "hash", "timestamp", "author", "branch_name", "tag" },
    },
  },
}
