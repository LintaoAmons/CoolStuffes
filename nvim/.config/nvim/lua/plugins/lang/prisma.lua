vim.api.nvim_create_augroup("langPrisma", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = "langPrisma",
  pattern = {
    "*.prisma",
  },
  command = "setlocal shiftwidth=2 tabstop=2",
})

return {}
