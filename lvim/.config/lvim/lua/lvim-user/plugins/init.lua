local plugins = {
  -- { "Exafunction/codeium.vim" },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        execution_message = nil
      })
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  {
    "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
      })
    end,
    requires = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  { "tpope/vim-fugitive" },
  { "gennaro-tedesco/nvim-jqx" },
  -- { "nvim-zh/auto-save.nvim" },
  { "aduros/ai.vim" },
  { "stevearc/oil.nvim" },
  { "ray-x/go.nvim" },
  { "ray-x/guihua.lua" },
  -- {
  --   'dense-analysis/neural',
  --   config = function()
  --     require('neural').setup({
  --       open_ai = {
  --         api_key = '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'
  --       }
  --     })
  --   end,
  --   requires = {
  --     'MunifTanjim/nui.nvim',
  --     'ElPiloto/significant.nvim'
  --   }
  -- },
  {
    'rareitems/printer.nvim',
    config = function()
      require('printer').setup({
        keymap = "gp" -- Plugin doesn't have any keymaps by default
      })
    end
  },
  { "f-person/git-blame.nvim" },
  -- { "shortcuts/no-neck-pain.nvim" },
  { "LintaoAmons/scratch.nvim" },
  -- { "/Users/lintao/Documents/projects/scratch.nvim"},
  { "ggandor/leap.nvim" },
  -- {
  --   "ldelossa/nvim-ide",
  -- },
  { "stevearc/aerial.nvim" },
  {
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup {} end,
  },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },

  { "stevearc/dressing.nvim" },
  { "djoshea/vim-autoread" },
  { "glepnir/lspsaga.nvim" },
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = function()
      require("sniprun").setup {
        live_mode_toggle = "enable",
        display = {
          "Terminal",
        },
      }
    end,
  },
}

local colorschemes = {
  { "luisiacc/gruvbox-baby" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "catppuccin/nvim" },
  { "EdenEast/nightfox.nvim" },
  { "marko-cerovac/material.nvim" },
}

for _, value in ipairs(colorschemes) do
  table.insert(plugins, value)
end

-- require("lvim-user.plugins.nvim-ide")

return plugins
