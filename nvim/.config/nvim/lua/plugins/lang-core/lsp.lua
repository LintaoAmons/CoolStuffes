local goto_definition = function()
  vim.cmd("Lspsaga goto_definition")
  vim.cmd([[normal! zz]])
end
vim.keymap.set("n", "gd", goto_definition)
vim.api.nvim_create_user_command("GotoDefinition", goto_definition, {})

local goto_function_name = "AerialPrev"
vim.keymap.set("n", "gm", "<cmd>" .. goto_function_name .. "<cr>")
vim.api.nvim_create_user_command("GoToFunctionName", goto_function_name, {})

local function go_to_ref()
  local cmd = "Lspsaga finder"
  vim.keymap.set("n", "gr", "<cmd>" .. cmd .. "<cr>")
  vim.api.nvim_create_user_command("GoToReference", cmd, {})
end
go_to_ref()

local function go_to_type_def()
  local cmd = "Lspsaga goto_type_definition"
  vim.keymap.set("n", "gt", "<cmd>" .. cmd .. "<cr>")
  vim.api.nvim_create_user_command("GoToTypeDefinition", cmd, {})
end
go_to_type_def()

local function goto_error_then_hint()
  local pos_equal = function(p1, p2)
    local r1, c1 = unpack(p1)
    local r2, c2 = unpack(p2)
    return r1 == r2 and c1 == c2
  end

  local cmd = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR, wrap = true })
    local pos2 = vim.api.nvim_win_get_cursor(0)
    if pos_equal(pos, pos2) then
      vim.diagnostic.goto_next({ wrap = true })
    end
  end
  vim.keymap.set("n", "]e", cmd)
end
goto_error_then_hint()

local function rename()
  local cmd = "Lspsaga rename"
  vim.keymap.set("n", "<leader>rn", "<cmd>" .. cmd .. "<cr>")
end
rename()

local function goto_error_then_hint_prev()
  local pos_equal = function(p1, p2)
    local r1, c1 = unpack(p1)
    local r2, c2 = unpack(p2)
    return r1 == r2 and c1 == c2
  end

  local cmd = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR, wrap = true })
    local pos2 = vim.api.nvim_win_get_cursor(0)
    if pos_equal(pos, pos2) then
      vim.diagnostic.goto_prev({ wrap = true })
    end
  end
  vim.keymap.set("n", "[e", cmd)
end
goto_error_then_hint_prev()

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.server_capabilities.documentHighlightProvider then
      local highlight_augroup =
        vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = "kickstart-lsp-highlight",
            buffer = event2.buf,
          })
        end,
      })
    end

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "[T]oggle Inlay [H]ints" })
    end
  end,
})

return {
  -- Mason install and manage LSP servers
  {
    "williamboman/mason.nvim",
    config = function(_, opts)
      require("mason").setup()
    end,
  },

  -- mason-lspconfig.nvim closes some gaps that exist between mason.nvim and lspconfig.
  {
    "williamboman/mason-lspconfig.nvim",
    config = function(_, opts)
      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = opts.servers or {}

      -- you can extend the servers table inside lang specific config
      -- for example, in ../lang/lua-and-example.lua
      -- servers.lua_ls = {
      --   -- cmd = {...},
      --   -- filetypes = { ...},
      --   -- capabilities = {},
      --   settings = {
      --     Lua = {
      --       completion = {
      --         callSnippet = "Replace",
      --       },
      --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      --       -- diagnostics = { disable = { 'missing-fields' } },
      --     },
      --   },
      -- }

      -- TODO: put this in to config of `neovim/nvim-lspconfig`
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities =
        vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      local config = {
        ensure_installed = opts.ensure_installed,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities =
              vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
      -- vim.print(config) -- uncommant this line to see the config
      require("mason-lspconfig").setup(config)
    end,
  },

  -- LSP Configuration & Plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function(_, opts) end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("lsp_signature").setup({
        floating_window = false,
        hint_prefix = "", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
        -- or, provide a table with 3 icons
        -- hint_prefix = {
        --     above = "↙ ",  -- when the hint is on the line above the current line
        --     current = "← ",  -- when the hint is on the same line
        --     below = "↖ "  -- when the hint is on the line below the current line
        -- }
        hint_scheme = "String",
        hint_inline = function()
          return false
        end,
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    config = function()
      require("mason-tool-installer").setup({

        -- a list of all tools you want to ensure are installed upon
        -- start
        ensure_installed = {

          -- you can pin a tool to a particular version
          -- { "golangci-lint", version = "v1.47.0" },

          -- you can turn off/on auto_update per tool
          { "bash-language-server", auto_update = true },

          -- frontend
          -- frontend.tailwindcss
          "tailwindcss-language-server",

          -- terraform
          "terraform-ls",
          "tflint",
          "tfsec",

          "lua-language-server",
          "vim-language-server",
          "stylua",
          "shellcheck",
          "editorconfig-checker",

          "impl",
          "json-to-struct",
          "luacheck",
          "misspell",
          "shellcheck",
          "shfmt",
          "staticcheck",
          -- golang
          -- "gopls",
          -- "gofumpt",
          -- "golines",
          -- "gomodifytags",
          -- "gotests",
          --
          -- "revive",
          -- "vint",
        },

        -- if set to true this will check each tool for updates. If updates
        -- are available the tool will be updated. This setting does not
        -- affect :MasonToolsUpdate or :MasonToolsInstall.
        -- Default: false
        auto_update = false,

        -- automatically install / update on startup. If set to false nothing
        -- will happen on startup. You can use :MasonToolsInstall or
        -- :MasonToolsUpdate to install tools and check for updates.
        -- Default: true
        run_on_start = true,

        -- set a delay (in ms) before the installation starts. This is only
        -- effective if run_on_start is set to true.
        -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
        -- Default: 0
        start_delay = 3000, -- 3 second delay

        -- Only attempt to install if 'debounce_hours' number of hours has
        -- elapsed since the last time Neovim was started. This stores a
        -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
        -- This is only relevant when you are using 'run_on_start'. It has no
        -- effect when running manually via ':MasonToolsInstall' etc....
        -- Default: nil
        debounce_hours = 5, -- at least 5 hours between attempts to install/update

        -- By default all integrations are enabled. If you turn on an integration
        -- and you have the required module(s) installed this means you can use
        -- alternative names, supplied by the modules, for the thing that you want
        -- to install. If you turn off the integration (by setting it to false) you
        -- cannot use these alternative names. It also suppresses loading of those
        -- module(s) (assuming any are installed) which is sometimes wanted when
        -- doing lazy loading.
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = true,
        },
      })
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        -- symbol_in_winbar = {
        --   enable = false,
        -- },
        lightbulb = {
          enable = false,
          enable_in_insert = false,
          -- sign = true,
          -- sign_priority = 40,
          -- virtual_text = false,
        },
        outline = {
          auto_preview = false,
        },
        definition = {
          keys = {
            edit = "o",
          },
        },
      })
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
}
