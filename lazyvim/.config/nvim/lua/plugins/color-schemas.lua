return {
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    config = function()
      require("tint").setup({
        tint = 5, -- Darken colors, use a positive value to brighten
        saturation = 0.3, -- Saturation to preserve
        transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
        tint_background_colors = true, -- Tint background portions of highlight grou})
      })
    end,
  },
  {
    "lintaoAmons/material.nvim",
    config = function()
      require("material").setup({
        contrast = {
          non_current_windows = true,
        },
      })
      vim.g.material_style = "darker"
    end,
  },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material",
    },
  },
}
