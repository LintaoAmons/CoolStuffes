vim.api.nvim_create_augroup("langLua", { clear = true })

-- Set indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "langLua",
  pattern = {
    "*.lua",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

return {
  -- {
  --   dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
  --   opts = function(_, opts)
  --     local new_item = {
  --       cmd = "test",
  --       callback = function(_)
  --         vim.print("test")
  --       end,
  --     }
  --     opts.add_menu_items = opts.add_menu_items or {}
  --     table.insert(opts.add_menu_items, new_item)
  --   end,
  -- },
  -- treesitter syntax hightlight
  {
    "stevearc/conform.nvim",

    opts = function(_, opts)
      opts.formatters_by_ft["lua"] = { "stylua" }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "lua" })
      end
    end,
  },

  -- mason lsp,debugger install
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "lua-language-server")
    end,
  },
}
