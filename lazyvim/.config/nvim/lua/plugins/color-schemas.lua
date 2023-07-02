return {
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    config = function()
      require("tint").setup()
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
