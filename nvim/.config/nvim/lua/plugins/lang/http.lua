return {
  {
    dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
    opts = function(_, opts)
      local new_item = {
        cmd = "Send HTTP Request",
        ft = {"http"},
        action = {
          type = "callback",
          callback = function(_)
            require("kulala").run()
          end,
        },
      }
      opts.add_menu_items = opts.add_menu_items or {}
      table.insert(opts.add_menu_items, new_item)
    end,
  },

  -- HTTP REST-Client Interface
  {
    "mistweaverco/kulala.nvim",
    config = function()
      -- Setup is required, even if you don't pass any options
      require("kulala").setup()
    end,
  },
}
