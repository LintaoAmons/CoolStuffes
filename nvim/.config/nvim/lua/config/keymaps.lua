local command1 = "split"
vim.keymap.set("n", "<leader>ws", "<cmd>" .. command1 .. "<cr>")
vim.api.nvim_create_user_command("SplitHorizotally", command1, {})

local command5 = "FzfLua live_grep"
vim.keymap.set("n", "<leader>ff", "<cmd>" .. command5 .. "<cr>")
vim.api.nvim_create_user_command("LiveGrepInProject", command5, {})

local quitNvim = "qa!"
vim.keymap.set("n", "<M-q>", "<cmd>" .. quitNvim .. "<cr>")
vim.api.nvim_create_user_command("QuitNvim", quitNvim, {})

local no_highlight = "nohlsearch"
vim.keymap.set("n", "<leader>nl", "<cmd>" .. no_highlight .. "<cr>")

local dont_replace_register = "P"
vim.keymap.set("v", "p", dont_replace_register)

local better_j = "gj"
vim.keymap.set("n", "j", better_j)

local better_k = "gk"
vim.keymap.set("n", "k", better_k)

local exit_alias = "<ESC>"
vim.keymap.set("i", "jk", exit_alias)

local reload_buffer = "checktime"
vim.api.nvim_create_user_command("ReloadBuffer", reload_buffer, {})

