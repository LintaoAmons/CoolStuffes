-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").treesitter() end, {})
-- stylua: ignore end

return {
  "folke/flash.nvim",
  event = "VeryLazy",

  ---@type Flash.Config
  opts = {},
}
