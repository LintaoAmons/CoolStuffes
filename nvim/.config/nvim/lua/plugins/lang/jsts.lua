local group_name = "langJsTs"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- use as example to show how to automatically set the indentation of a specific filetype
-- Set indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = group_name,
  pattern = {
    "*.js",
    "*.ts",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

return {
  -- # Syntax hightlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.g.config_utils.opts_ensure_installed(opts, {
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "prisma",
      })
    end,
  },

  -- # LSP
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        -- NOTE: use vtsls instead of typescript-language-server
        "yioneko/nvim-vtsls",
        lazy = true,
        opts = {},
        config = function()
          require("vtsls").config({})
        end,
      },
    },
    opts = function(_, opts)
      -- ## ensure install lang specfic LSP
      vim.g.config_utils.opts_ensure_installed(opts, { "lua_ls" })

      -- ## extend the servers table
      opts.servers = opts.servers or {}

      opts.servers.tsserver = {
        enabled = false,
      }
      opts.servers.vtsls = {
        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      }
    end,
  },

  -- # Format
  {
    "stevearc/conform.nvim",
    -- use opts to extend the formatters_by_ft table
    opts = function(_, opts)
      opts.formatters_by_ft["javascript"] = { "prettier" }
      opts.formatters_by_ft["typescript"] = { "prettier" }
      opts.formatters_by_ft["tsx"] = { "prettier" }
      opts.formatters_by_ft["jsx"] = { "prettier" }
      opts.formatters_by_ft["jsdoc"] = { "prettier" }
    end,
  },

  -- # Debug
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    config = function()
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
        adapters = { "chrome", "pwa-node", "pwa-chrome", "pwa-msedge", "pwa-extensionHost" },
      })
    end,
  },
  -- ## Parse launch.json
  { "Joakker/lua-json5", build = "./install.sh" },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Current File (pwa-node with ts-node)",
            -- cwd = vim.fn.getcwd(),
            cwd = "${workspaceFolder}",
            -- runtimeArgs = { "--loader", "ts-node/esm" },
            runtimeExecutable = "ts-node",
            args = { "${file}" },
            sourceMaps = true,
            protocol = "inspector",
            skipFiles = { "<node_internals>/**", "node_modules/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}

-- REFs:
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua
-- - https://github.com/AstroNvim/astrocommunity/blob/f219659b67b246584c421074d73db0a941af5cbd/lua/astrocommunity/pack/typescript/init.lua
-- - https://github.com/anasrar/.dotfiles/blob/4c444c3ab2986db6ca7e2a47068222e47fd232e2/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua
