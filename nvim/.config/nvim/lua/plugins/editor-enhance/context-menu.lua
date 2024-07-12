local trigger_context_menu = function()
  require("context-menu").trigger_context_menu()
end
vim.keymap.set({ "v", "n" }, "<M-l>", trigger_context_menu, {})

return {
  dir = "/Volumes/t7ex/Documents/oatnil/beta/context-menu.nvim",
  config = function(_, opts)
    require("context-menu").setup(opts)
  end,
}
