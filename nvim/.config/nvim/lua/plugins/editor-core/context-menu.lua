local trigger_context_menu = function()
  require("context-menu").trigger_context_menu()
end
vim.keymap.set({ "v", "n" }, "<M-l>", trigger_context_menu, {})

return {
  dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
  config = function(_, opts)
    ---@type ContextMenu.Items
    local addition_items = {
      {
        order = 1,
        cmd = "Code Action",
        not_ft = { "markdown" },
        action = {
          type = "callback",
          callback = function(_)
            vim.cmd([[Lspsaga code_action]])
          end,
        },
      },
      {
        order = 2,
        cmd = "Run Test",
        not_ft = { "markdown" },
        filter_func = function(context)
          return string.match(context.filename, "%.test%.") ~= nil
        end,
        action = {
          type = "callback",
          callback = function(_)
            require("neotest").run.run()
          end,
        },
      },
    }
    opts.add_menu_items = opts.add_menu_items or {}
    for _, i in pairs(addition_items) do
      table.insert(opts.add_menu_items, i)
    end

    require("context-menu").setup(opts)
  end,
}
