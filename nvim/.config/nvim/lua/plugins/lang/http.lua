return {
  {
    dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
    opts = function()
      require("context-menu").setup({
        menu_items = {
          {
            cmd = "Send HTTP Request",
            ft = { "http" },
            action = {
              type = "callback",
              callback = function(_)
                require("kulala").run()
              end,
            },
          },
        },
      })
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
