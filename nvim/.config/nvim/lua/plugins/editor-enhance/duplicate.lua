-- SplitHorizotally
vim.keymap.set("v", "<C-M-j>", "<CMD>VisualDuplicate +1<CR>", { desc = "Duplication" })
-- end

return {
  "hinell/duplicate.nvim",
  event = "VeryLazy",
}
