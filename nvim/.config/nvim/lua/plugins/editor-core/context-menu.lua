vim.keymap.set({ "v", "n" }, "<M-l>", function()
  require("context-menu").trigger_context_menu()
end, {})

return {
  dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
  config = function()
    require("context-menu").setup({
      close_menu = { "q", "<ESC>", "<M-l>" },
      menu_items = {
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
            local a = context.filename
            if string.find(a, ".test.") or string.find(a, "spec.") then
              return true
            else
              return false
            end
          end,
          action = {
            type = "callback",
            callback = function(_)
              require("neotest").run.run()
            end,
          },
        },
      },
    })
  end,
}
