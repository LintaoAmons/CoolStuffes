return {
  "glepnir/lspsaga.nvim",
  event = "LspAttach",
  config = function()
    require("lspsaga").setup({})
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
