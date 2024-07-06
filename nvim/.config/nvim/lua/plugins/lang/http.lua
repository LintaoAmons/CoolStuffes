-- use as example to show how to create a language autocmd group
local name = "langHttp"
vim.api.nvim_create_augroup(name, { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = name,
  pattern = {
    "*.http",
  },
  callback = function()
    vim.keymap.set("n", "<M-r>", "<Cmd>Rest run<CR>", {
      noremap = true,
      silent = true,
      nowait = true,
      buffer = vim.api.nvim_get_current_buf(),
    })
  end,
})

return {}
