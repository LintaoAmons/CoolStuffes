return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("nordic")
    end,
    config = function()
      -- stylua ignore
      require("nordic").setup({
        override = {
          Visual = { bg = "#BB4747", fg = "white" },
          DapBreakpoint = { bg = "#552B24" },
          DapBreakpointStopped = { bg = "#244C55" },
          TreesitterContext = { bg = "#2A1E39" },
        },

        -- original palatte: https://github.com/AlexvZyl/nordic.nvim/blob/main/lua/nordic/colors/nordic.lua
        on_palette = function(palette)
          local custom_palette = {
            -- Blacks. Not in base Nord.
            black0 = "#30222A", -- cursorline color
            black1 = "#1E222A", -- telescope background color
            -- Slightly darker than bg.  Very useful for certain popups
            black2 = "#222630",
            -- This color is used on their website's dark theme.
            gray0 = "#1D2026", -- bg
            -- 2B2E32 monokai
            -- Polar Night.
            gray1 = "#2E3440",
            gray2 = "#3B4252",
            gray3 = "#434C5E",
            gray4 = "#4C566A",
          }

          return vim.tbl_deep_extend("force", palette, custom_palette)
        end,
      })
    end,
  },
  -- {
  --   "malbernaz/monokai.nvim",
  --   lazy = false,
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme("monokai")
  --   end,
  --
  --   config = function()
  --     require("monokai").setup({
  --       custom_hlgroups = {
  --         FlashCurrent = { fg = "#FF0000", bg = "#FF0000" },
  --         FlashLabel = { fg = "#FBF3CB", bg = "#FF007C" },
  --         FlashMatch = { fg = "#000000", bg = "#000000" },
  --       },
  --     })
  --   end,
  -- },
}
