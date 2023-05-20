lvim.builtin.alpha.active = false

local plugins = {
  {
    "RRethy/vim-illuminate",
    lazy = true
  },
  {
    "folke/trouble.nvim",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "folke/todo-comments.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    "LintaoAmons/auto-save.nvim",
    event = 'VimEnter',
  },
  {
    "christoomey/vim-tmux-navigator",
    event = 'VimEnter',
  },
  {
    "LintaoAmons/scratch.nvim",
    event = 'VimEnter',
  },
  {
    "stevearc/aerial.nvim",
    event = 'VimEnter',
    config = function()
      require('aerial').setup()
    end
  },
  {
    'stevearc/dressing.nvim',
    event = 'VimEnter',
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'VimEnter',
    -- lazy = true,
  },
  {
    "tpope/vim-fugitive",
    event = 'VimEnter',
  },
  {
    "kylechui/nvim-surround",
    event = 'VimEnter',
    config = function() require("nvim-surround").setup {} end,
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
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
    lazy = true,
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
  {
    'ggandor/leap.nvim',
    lazy = true
  },
  {
    "nvim-neotest/neotest",
    lazy = true,
    dependencies = {
      "nvim-neotest/neotest-go",
      -- Your other test adapters here
    },
    config = function()
      -- get neotest namespace (api call creates or returns namespace)
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message =
                diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        -- your neotest config here
        adapters = {
          require("neotest-go")({
            -- experimental = {
            --   test_table = true,
            -- },
            args = { "-count=1", "-timeout=60s" }
          })
        },
      })
    end,
  },
  -- 🔥 Fold
  {
    'kevinhwang91/nvim-ufo',
    event = 'VimEnter',
    dependencies = { 'kevinhwang91/promise-async' }
  },
  {
    "luukvbaal/statuscol.nvim",
    event = 'VimEnter',
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        relculright = true,
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          {
            sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
            click = "v:lua.ScSa"
          },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
          {
            sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
            click = "v:lua.ScSa"
          },
        }
      })
    end,
  },
  -- 🔥 Golang
  {
    'leoluz/nvim-dap-go',
    lazy = true,
    config = function()
      require('dap-go').setup()
    end
  },
  {
    "olexsmir/gopher.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  },
  -- {
  --   "ray-x/go.nvim",
  --   dependencies = { -- optional packages
  --     "ray-x/guihua.lua",
  --     "neovim/nvim-lspconfig",
  --     "nvim-treesitter/nvim-treesitter",
  --     "theHamsta/nvim-dap-virtual-text",
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
    lazy = true,
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    lazy = true,
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- 🔥 Color scheme
  {
    "lintaoAmons/material.nvim",
    config = function()
      require('material').setup({
        contrast = {
          non_current_windows = true,
        },
      })
    end
  },
}

return plugins
