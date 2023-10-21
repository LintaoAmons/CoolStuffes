vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#FF0000", bg = "#FF0000" })
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#FBF3CB", bg = "#FF007C" })
vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#000000" })

return {
  -- {
  --   "levouh/tint.nvim",
  --   config = function()
  --     -- Default configuration
  --     require("tint").setup({
  --       tint = -80, -- Darken colors, use a positive value to brighten
  --       saturation = 0.4, -- Saturation to preserve
  --       transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
  --       tint_background_colors = true, -- Tint background portions of highlight groups
  --       highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
  --       window_ignore_function = function(winid)
  --         local bufid = vim.api.nvim_win_get_buf(winid)
  --         local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
  --         local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
  --
  --         -- Do not tint `terminal` or floating windows, tint everything else
  --         return buftype == "terminal" or floating
  --       end,
  --     })
  --   end,
  -- },
  -- {"blueyed/vim-diminactive"},
  {

    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.animate = { enabled = false }
    end,
  },
  -- {
  --   "folke/edgy.nvim",
  --   opts.animate = {enabled = false}
  -- },
  {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "folke/twilight.nvim",
    event = "VeryLazy",
    config = function()
      require("twilight").setup({
        dimming = {
          alpha = 0.25, -- amount of dimming
          -- we try to get the foreground from the highlight groups or fallback color
          color = { "Normal", "#ffffff" },
          term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
          inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
          expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
            -- "function",
            -- "method",
            -- "table",
            -- "if_statement",
            -- "for_statement",
          },
        },
      })
      -- vim.cmd("Twilight") enable Twilight at vim startup
    end,
  },
  -- -- add gruvbox
  -- { "ellisonleao/gruvbox.nvim" },
  --
  -- -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "gruvbox",
  --   },
  -- },
  --

  -- { "savq/melange-nvim" },

  {
    "malbernaz/monokai.nvim",
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
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai",
    },
  },
}
