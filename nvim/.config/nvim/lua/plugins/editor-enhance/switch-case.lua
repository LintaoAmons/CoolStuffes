vim.keymap.set({ "n", "x" }, "<leader>sc", "<cmd>TextCaseOpenTelescope<CR>")

return {
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
  },
}
