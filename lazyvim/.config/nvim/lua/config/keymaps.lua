-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "<leader>l", {})
vim.keymap.del({ "n", "i", "v" }, "<A-j>", {})
vim.keymap.del({ "n", "i", "v" }, "<A-k>", {})

local command_keymappings = {
  -- HACK: Debug
  ["ToggleDebugUI"] = "<M-5>",
  ["DebugStartOrContinue"] = "<F5>",
  ["DebugToggleBreakpoint"] = "<F9>",
  ["DebugStepOver"] = "<F8>",
  ["DebugStepInto"] = "<F7>",
  ["DebugStop"] = "<M-F2>",
  ["TriggerLastRun"] = "<leader>rr",

  -- HACK: DB
  ["DBUIToggle"] = "<M-C-9>",

  -- ["SearchSession"] = "<C-q>",
  ["PeekGitChange"] = "<M-k>j",
  ["GitCommit"] = "<M-k>c",
  -- ["SelectBySyntax"] = "S",
  ["Twilight"] = "<C-w>m",
  ["AskGpt4"] = "<C-g>k",
  ["GpAppend"] = { keys = "<M-k>i", mode = "v" },
  -- ["NewFile"] = "<C-n>",
  ["TmuxNavigateLeft"] = "<C-h>",
  ["TmuxNavigateRight"] = "<C-l>",
  ["TmuxNavigateUp"] = "<M-k>",
  ["TmuxNavigateDown"] = "<C-j>",
  ["FoldAll"] = "<leader>zc",
  ["UnFoldAll"] = "<leader>zo",
  ["FindCommands"] = { mode = "niv", keys = "<C-M-p>" },
  ["FindFiles"] = "<C-p>",
  ["NoHighlight"] = "<leader>nl",
  ["FormatCode"] = "<leader>fm",
  ["QuitNvim"] = "<M-q>",
  ["CloseWindowOrBuffer"] = "<M-w>",
  ["SplitVertically"] = "<leader>wl",

  -- ["DecreaseSplitWidth"] = "<C-M-h>",
  -- ["IncreaseSplitWidth"] = "<C-M-l>",

  ["ToggleOutline"] = "<leader>ss",
  ["ToggleLf"] = "<leader>oo",
  ["RunCurrentBuffer"] = "<M-r>",
  ["Scratch"] = "<M-C-n>",
  ["ScratchOpen"] = "<M-C-o>",
  ["FindInProject"] = { mode = "nv", keys = "<C-f>f" },
  ["FindFileInDir"] = { mode = "nv", keys = "<C-f>d" },
  ["GrepInDir"] = { mode = "nv", keys = "<C-f>g" },
  ["SearchOrReplace"] = { mode = "nv", keys = "<C-M-f>" },
  ["Rename"] = "<leader>rn",
  -- HACK: GIT
  ["GitNextHunk"] = "gj",
  ["GitPrevHunk"] = "gk",
  ["GitDiff"] = "<M-0>",
  ["GitStatus"] = "<leader>gs",
  ["Git"] = "<leader>gg",
  ["BlameLine"] = "<leader>gl",
  ["BufferPrev"] = "<S-h>",
  ["BufferNext"] = "<S-l>",
  ["TabClose"] = "tt",
  ["TabPrev"] = "th",
  ["TabNext"] = "tl",
  ["ExplorerLocateCurrentFile"] = "<leader>fl",

  ["GoToTestFile"] = "gt",
  ["TestRunNearest"] = "<leader>rt",
  ["GoToDefinition"] = "gd",
  ["GoToDefinitionInSplit"] = "gl",
  ["PeekDefinition"] = "<M-k>k",
  ["PeekTypeDefinition"] = "<M-k>l",
  ["GotoFunctionName"] = "gm",

  -- ["CodeActions"] = "<M-k><M-k>",
  ["LspFinder"] = "<M-k>f",
  -- ["ExtractVariable"] = "<leader>ev",

  -- ["Mark"] = "m",
  -- ["MarkList"] = "<C-M-i>",
  ["ToNextCase"] = { mode = "nv", keys = "<leader>nc" },
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

    if not key then
      vim.print(command)
    end

    local modes = keybinding.mode or "n"
    for i = 1, #modes do
      local char = string.sub(modes, i, i)
      vim.keymap.set(char, key, "<CMD>" .. command .. "<CR>", {})
    end
  end
end

vim.keymap.set("n", "<leader>wo", "<c-w>o", { desc = "Maximize window" })

vim.keymap.set("v", "p", "P")

-- explorer
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })
vim.keymap.set("n", "<leader>fl", "<cmd>Neotree reveal<cr>", { desc = "ExplorerFindFileLocation" })

vim.keymap.set("n", "<M-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })
vim.keymap.set("n", "ma", "mA", { desc = "Mark" })
vim.keymap.set("n", "'a", "'A", { desc = "GoToMark" })

vim.keymap.set("n", "<M-e>", "<cmd>Telescope frecency<cr>", { desc = "FindRecentFiles" })
vim.keymap.set("n", "<M-k><M-k>", "<cmd>Lspsaga code_action<cr>", { desc = "CodeActions" })

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `vim.keymap.set` instead
local Util = require("lazyvim.util")
local map = Util.safe_keymap_set
map("n", "<C-M-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
map("n", "<C-M-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })

-- TODO: Move to easy-commands
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

local lazyterm = function()
  require("lazyvim.util").terminal.open(nil, { cwd = require("lazyvim.util").root.get() })
end
map("n", "<c-\\>", lazyterm, { desc = "Terminal (root dir)" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local function neovideMacCopy()
  -- Allow clipboard copy paste in neovim
  vim.g.neovide_input_use_logo = 1
  vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end

if vim.g.neovide then
  vim.keymap.set("n", "<D-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })
  vim.keymap.set("n", "<D-e>", "<cmd>Telescope frecency<cr>", { desc = "FindRecentFiles" })
  map("n", "<C-D-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
  map("n", "<C-D-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
end
neovideMacCopy()
registerKeys()
