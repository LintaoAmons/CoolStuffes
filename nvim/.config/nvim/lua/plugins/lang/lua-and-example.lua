vim.api.nvim_create_augroup("langLua", { clear = true })

-- Set indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "langLua",
  pattern = {
    "*.lua",
  },
  command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})

return {
  -- # Syntax hightlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- ## use opts to extend the ensure_installed table
      vim.g.config_utils.opts_ensure_installed(opts, {
        "lua",
        "luadoc",
      })
    end,
  },

  -- # LSP
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- ## ensure_install lang specfic LSP
      vim.g.config_utils.opts_ensure_installed(opts, { "lua_ls" })

      -- ## extend the servers table
      opts.servers = opts.servers or {}
      opts.servers.lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
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
      opts.formatters_by_ft["lua"] = { "stylua" }
    end,
  },
}
