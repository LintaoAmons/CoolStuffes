vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#FF0000", bg = "#FF0000" })
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#FBF3CB", bg = "#FF007C" })
vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#000000" })

return {
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}