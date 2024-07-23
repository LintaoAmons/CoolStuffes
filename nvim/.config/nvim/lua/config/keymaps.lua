-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

local smart_open_cmd = function()
  require("telescope").extensions.smart_open.smart_open({
    cwd_only = true,
    filename_first = false,
  })
end
vim.keymap.set("n", "<C-p>", smart_open_cmd, { silent = true })

local smart_open_all = function()
  require("telescope").extensions.smart_open.smart_open({
    cwd_only = false,
    filename_first = false,
  })
end
vim.api.nvim_create_user_command("SmartOpenAll", smart_open_all, {})

local command1 = "split"
vim.keymap.set("n", "<leader>ws", "<cmd>" .. command1 .. "<cr>")
vim.api.nvim_create_user_command("SplitHorizotally", command1, {})

local command2 = "AerialToggle"
vim.keymap.set("n", "<leader>ss", "<cmd>" .. command2 .. "<cr>")
vim.api.nvim_create_user_command("ToggleOutline", command2, {})
local command3 = "Lspsaga peek_definition"
vim.keymap.set("n", "<leader>ss", "<cmd>" .. command3 .. "<cr>")
vim.api.nvim_create_user_command("PeekDefinition", command3, {})
local command4 = "Neotree reveal reveal_force_cwd"
vim.keymap.set("n", "<leader>fl", "<cmd>" .. command4 .. "<cr>")
vim.api.nvim_create_user_command("LocateCurrentBuf", command4, {})
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

vim.keymap.set("n", "<M-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })

-- diagnostic

vim.keymap.set("n", "<C-M-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-M-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })


local command_keymappings = {
  ["Scratch"] = "<M-C-n>",
  ["ScratchOpen"] = "<M-C-o>",
  ["Rename"] = "<leader>rn",

  -- HACK: GIT
  ["GitDiff"] = "<M-0>",
  ["GitStatus"] = "<leader>gs",
  ["Git"] = "<leader>gg",
  ["BlameLine"] = "<leader>gl",
}

-- neovide use <D-key> represents the cmd key in mac
local function convertNeovideCMDKey(key)
  if vim.g.neovide then
    return string.gsub(key, "M%-", "D-")
  else
    return key
  end
end

local function getKey(keybinding)
  if type(keybinding) == "string" then
    return keybinding
  else
    return keybinding.keys
  end
end

local function registerKeys()
  for command, keybinding in pairs(command_keymappings) do
    local key = convertNeovideCMDKey(getKey(keybinding))

    local modes = keybinding.modes and vim.split(keybinding.modes, ",") or { "n" }
    vim.keymap.set(modes, key, "<CMD>" .. command .. "<CR>", {})
  end
end

registerKeys()
