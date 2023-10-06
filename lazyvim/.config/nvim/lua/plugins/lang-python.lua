return {
  -- Add `pyright` to mason
  -- TODO: check following tools -> mypy types-requests types-docutils
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- vim.list_extend(opts.ensure_installed, { "pyright", "black", "ruff-lsp", "ruff" })
      vim.list_extend(opts.ensure_installed, {
        "black",
        "ruff",
        "debugpy",
      })
    end,
  },
  -- {
  --   "puremourning/vimspector",
  -- },
  --
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local path = require("mason-registry").get_package("debugpy"):get_install_path()
      require("dap-python").setup(path .. "/venv/bin/python")
    end,
  },

  -- Add `python` debugger to mason DAP to auto-install
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
      })
    end,
  },

  -- Add `server` and setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {},
    opts = {
      servers = {
        -- pyright = {},
        ruff_lsp = {},
      },
    },
  },

  -- Setup null-ls with `black`
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.black,
        -- nls.builtins.formatting.black.with({
        --   extra_args = { "--preview" },
        -- }),
        nls.builtins.formatting.ruff,
        -- nls.builtins.diagnostics.ruff,
      })
    end,
  },
}
