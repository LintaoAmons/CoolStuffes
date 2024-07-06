return {
  -- {
  --   "NStefan002/visual-surround.nvim",
  --   opts = {
  --     surround_chars = { "[", "]", "(", ")", "'", '"', "`" },
  --   },
  -- },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
