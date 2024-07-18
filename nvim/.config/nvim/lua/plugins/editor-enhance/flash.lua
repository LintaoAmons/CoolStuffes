-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "ss", function() require("flash").treesitter() end, {})
vim.keymap.set({ "n", "x", "o" }, "sj", function() require("flash").jump() end, {})
-- stylua: ignore end

return {
  "folke/flash.nvim",
  event = "VeryLazy",

  ---@type Flash.Config
  opts = {},
}
