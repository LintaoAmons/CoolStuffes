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
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' }
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      -- local builtin = require("statuscol.builtin")
      require("statuscol").setup({
      })
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "LintaoAmons/scratch.nvim" },
  {
    "stevearc/aerial.nvim",
    config = function()
      require('aerial').setup()
    end
  },
  { 'stevearc/dressing.nvim' },
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
  { 'ibhagwan/fzf-lua' },
  { "ggandor/leap.nvim" },
  -- 🔥 Golang
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   config = function()
  --     require("go").setup()
  --   end,
  --   event = { "CmdlineEnter" },
  --   ft = { "go", 'gomod' },
  --   build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  -- },
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
