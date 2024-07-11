-- REFs:
-- - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/lang/typescript.lua
-- - https://github.com/AstroNvim/astrocommunity/blob/f219659b67b246584c421074d73db0a941af5cbd/lua/astrocommunity/pack/typescript/init.lua
-- - https://github.com/anasrar/.dotfiles/blob/4c444c3ab2986db6ca7e2a47068222e47fd232e2/neovim/.config/nvim/lua/rin/DAP/languages/typescript.lua

return {
  -- add typescript to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(
          opts.ensure_installed,
          { "javascript", "typescript", "tsx", "jsdoc", "prisma" }
        )
      end
    end,
  },

  -- NOTE: use vtsls instead of typescript-language-server
  {
    "yioneko/nvim-vtsls",
    lazy = true,
    opts = {},
    config = function(_, opts)
      require("vtsls").config(opts)
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        tsserver = {
          enabled = false,
        },
        vtsls = {
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
          -- keys = {
          --   {
          --     "gD",
          --     function()
          --       require("vtsls").commands.goto_source_definition(0)
          --     end,
          --     desc = "Goto Source Definition",
          --   },
          --   {
          --     "gR",
          --     function()
          --       require("vtsls").commands.file_references(0)
          --     end,
          --     desc = "File References",
          --   },
          --   {
          --     "<leader>co",
          --     function()
          --       require("vtsls").commands.organize_imports(0)
          --     end,
          --     desc = "Organize Imports",
          --   },
          --   {
          --     "<leader>cM",
          --     function()
          --       require("vtsls").commands.add_missing_imports(0)
          --     end,
          --     desc = "Add missing imports",
          --   },
          --   {
          --     "<leader>cu",
          --     function()
          --       require("vtsls").commands.remove_unused_imports(0)
          --     end,
          --     desc = "Remove unused imports",
          --   },
          --   {
          --     "<leader>cD",
          --     function()
          --       require("vtsls").commands.fix_all(0)
          --     end,
          --     desc = "Fix all diagnostics",
          --   },
          --   {
          --     "<leader>cV",
          --     function()
          --       require("vtsls").commands.select_ts_version(0)
          --     end,
          --     desc = "Select TS workspace version",
          --   },
          -- },
        },
      },
      setup = {
        tsserver = function()
          -- disable tsserver
          return true
        end,
        vtsls = function(_, opts)
          -- copy typescript settings to javascript
          opts.settings.javascript = vim.tbl_deep_extend(
            "force",
            {},
            opts.settings.typescript,
            opts.settings.javascript or {}
          )
        end,
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
    },
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
