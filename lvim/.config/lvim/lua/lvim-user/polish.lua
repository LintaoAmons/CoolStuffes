require('aerial').setup()

require('oil').setup()

require("auto-save").on()

-- require("scratch").setup {
--   filetypes = { "csv","json", "xml", "go", "lua", "js", "py", "sh", "md", "txt", "sql", "ts" },
-- }
vim.keymap.set("n", "<M-C-n>", "<cmd>Scratch<cr>")
vim.keymap.set("n", "<M-C-o>", "<cmd>ScratchOpen<cr>")
