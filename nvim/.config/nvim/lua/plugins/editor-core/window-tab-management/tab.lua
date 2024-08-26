local tabNext = "tabnext"
vim.keymap.set("n", "tl", "<cmd>" .. tabNext .. "<cr>")

local tabPrevious = "tabprevious"
vim.keymap.set("n", "th", "<cmd>" .. tabPrevious .. "<cr>")

local tabClose = "tabclose"
vim.keymap.set("n", "tt", "<cmd>" .. tabClose .. "<cr>")

local find_tab = "FzfLua tabs"
vim.keymap.set("n", "tk", ":" .. find_tab .. "<cr>")
