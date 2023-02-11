require('aerial').setup()

require('oil').setup()

require("auto-save").on()

require("scratch").setup {
  filetypes = { "json", "xml", "go", "lua", "js", "py", "sh", "md", "txt", "sql", "ts" },
}
vim.keymap.set("n", "<M-C-n>", "<cmd>Scratch<cr>")
vim.keymap.set("n", "<M-C-o>", "<cmd>ScratchOpen<cr>")

-- go.nvim
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

require('go').setup()
