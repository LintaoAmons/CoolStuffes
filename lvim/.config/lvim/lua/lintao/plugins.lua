lvim.builtin.alpha.active = false

local plugins = {
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function()
      require "lsp_signature".setup({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded"
        }
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    }
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } }
  },
  {
    -- dir = "/Users/lintao.zhang/Documents/oatnil/release/easy-commands.nvim",
    "LintaoAmons/easy-commands.nvim",
    -- dir = "/Users/lintao/Documents/oatnil/beta/easy-commands.nvim",
    event = 'VimEnter',
    config = function()
      require("easy-commands").Setup({
        ["RunSelectedAndOutputWithPrePostFix"] = {
          prefix = "```lua",
          postfix = "```"
        }
      })
    end
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  },
  {
    "folke/neodev.nvim",
    ft = 'lua',
  },
  {
    'ThePrimeagen/harpoon',
    event = 'VimEnter'
  },
  {
    'ThePrimeagen/refactoring.nvim',
    event = 'VimEnter',
  },
  -- { 'preservim/vimux' },
  { 'ibhagwan/fzf-lua' },
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
    event = 'VimEnter',
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
    "christoomey/vim-tmux-navigator",
    event = 'VimEnter',
  },
  {
    "LintaoAmons/scratch.nvim",
    event = 'VimEnter',
  },
  {
    'stevearc/dressing.nvim',
    event = 'VimEnter',
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'VimEnter',
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
    event = 'VimEnter',
    build = "bash ./install.sh",
    config = function()
      -- HACK: https://michaelb.github.io/sniprun/sources/README.html#usage
      require("sniprun").setup {
        live_mode_toggle = "enable",
        display = {
          "Classic",       --# display results in the command-line  area
          "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
        },
        live_display = { "VirtualTextOk" },
      }
    end,
  },

  {
    'ggandor/leap.nvim',
    lazy = true
  },
  {
    "nvim-neotest/neotest",
    event = 'VimEnter',
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
    ft = "go",
    config = function()
      require('dap-go').setup()
    end
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
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
    "levouh/tint.nvim",
    event = 'VimEnter',
    config = function()
      require("tint").setup()
    end
  },
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
