return {
  "rest-nvim/rest.nvim",
  dependencies = { { "nvim-lua/plenary.nvim" } },
  config = function()
    require("rest-nvim").setup({
      --- Get the same options from Packer setup
    })
  end,
}
