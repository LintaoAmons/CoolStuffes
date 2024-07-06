return {
  {
    "malbernaz/monokai.nvim",
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme("monokai")
    end,

    config = function()
      require("monokai").setup({
        custom_hlgroups = {
          FlashCurrent = { fg = "#FF0000", bg = "#FF0000" },
          FlashLabel = { fg = "#FBF3CB", bg = "#FF007C" },
          FlashMatch = { fg = "#000000", bg = "#000000" },
        },
      })
    end,
  },
}
