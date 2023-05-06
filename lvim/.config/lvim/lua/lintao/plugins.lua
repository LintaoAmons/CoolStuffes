lvim.builtin.alpha.active = false

local plugins = {
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        execution_message = nil
      })
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "LintaoAmons/scratch.nvim" },
  { "stevearc/aerial.nvim" },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim'
  },
  { "tpope/vim-fugitive" },
  {
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup {} end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  },
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    config = function()
      require("sniprun").setup {
        live_mode_toggle = "enable",
        display = {
          "Terminal",
        },
      }
    end,
  },
  -- 🔥 Copilot
    {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- 🔥 Color scheme
  { "marko-cerovac/material.nvim" },
}

return plugins
