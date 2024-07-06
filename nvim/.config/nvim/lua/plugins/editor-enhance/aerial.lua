(function()
  local command = "AerialToggle"
  vim.keymap.set("n", "<leader>ss", "<cmd>" .. command .. "<cr>")
  vim.api.nvim_create_user_command("ToggleOutline", command, {})
end)()

return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  config = function()
    require("aerial").setup()
  end,
}
