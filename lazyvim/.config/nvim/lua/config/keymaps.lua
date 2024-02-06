-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "<leader>l", {})
vim.keymap.del({ "n", "i", "v" }, "<A-j>", {})
vim.keymap.del({ "n", "i", "v" }, "<A-k>", {})

local command_keymappings = {
  ["BookmarksGotoRecent"] = { modes = "n,v", keys = "mg" },
  ["BookmarksMark"] = "mm",
  ["BookmarksGoto"] = "mo",

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

  ["AskGpt4"] = "<C-g>k",
  ["GpAppend"] = { keys = "<M-k>i", modes = "v" },
  ["TmuxNavigateLeft"] = "<C-h>",
  ["TmuxNavigateRight"] = "<C-l>",
  ["TmuxNavigateUp"] = "<M-k>",
  ["TmuxNavigateDown"] = "<C-j>",
  ["FoldAll"] = "<leader>zc",
  ["UnFoldAll"] = "<leader>zo",
  ["FindCommands"] = { modes = "n,i,v", keys = "<C-M-p>" },
  ["FindFiles"] = "<C-p>",
  ["NoHighlight"] = "<leader>nl",
  ["Format"] = "<leader>fm",
  ["QuitNvim"] = "<M-q>",

  ["CloseWindowOrBuffer"] = "<M-w>",
  ["MaximiseWindow"] = "<Leader>wo",
  ["SplitVertically"] = "<leader>wl",

  ["RunCurrentBuffer"] = "<M-r>",
  ["RunShellAtBufDir"] = { modes = "n,v", keys = "<leader>rk" },
  ["Scratch"] = "<M-C-n>",
  ["ScratchOpen"] = "<M-C-o>",
  ["FindInProject"] = { modes = "n,v", keys = "<C-f>f" },
  ["FindFileInDir"] = { modes = "n,v", keys = "<C-f>d" },
  ["GrepInDir"] = { modes = "n,v", keys = "<C-f>g" },
  ["SearchOrReplace"] = { modes = "n,v", keys = "<C-M-f>" },
  ["Rename"] = "<leader>rn",
  ["CdProject"] = "<C-q>",

  -- HACK: GIT
  ["PeekGitChange"] = "<M-k>j",
  ["GitCommit"] = "<M-k>c",
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

  ["GoToTestFile"] = "gt",
  ["TestRunNearest"] = "<leader>rt",
  ["GoToDefinition"] = "gd",
  ["GoToDefinitionInSplit"] = "gl",
  ["PeekDefinition"] = "<M-k>k",
  ["PeekTypeDefinition"] = "<M-k>l",
  ["GoToFunctionName"] = "gm",

  ["LspFinder"] = "<M-k>f",

  ["SentToTerminalAndRun"] = { modes = "n,v", keys = "<leader>sj" },
  ["SendSelectedToTerminalAndRun"] = { modes = "n,v", keys = "<leader>sk" },
  ["SendLineToTerminalAndRun"] = { modes = "n,v", keys = "<leader>sl" },
  ["MaximiseWindowAsPopup"] = { modes = "n,v,t", keys = "<leader>wp" },
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

-- don't overwrite the clipboard
vim.keymap.set("v", "p", "P")

-- explorer
vim.keymap.set("n", "<leader>e", "<cmd>:lua MiniFiles.open()<cr>", { desc = "MiniFiles" })
vim.keymap.set(
  "n",
  "<leader>fl",
  "<cmd>Neotree reveal reveal_force_cwd<cr>",
  { desc = "ExplorerFindFileLocation" }
)
vim.keymap.set("n", "<M-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })

vim.keymap.set("n", "ma", "mA", { desc = "Mark" })
vim.keymap.set("n", "'a", "'A", { desc = "GoToMark" })

vim.keymap.set("n", "<M-e>", "<cmd>Telescope frecency<cr>", { desc = "FindRecentFiles" })
vim.keymap.set({ "n", "v" }, "<M-k><M-k>", "<cmd>Lspsaga code_action<cr>", { desc = "CodeActions" })
vim.keymap.set({ "i", "v", "t" }, "jk", [[<C-\><C-n>]], { buffer = 0 })

vim.keymap.set("n", "<leader>ss", "<cmd>AerialNavToggle<cr>", { desc = "ToggleOutline" })
vim.keymap.set("v", "<C-M-j>", "<CMD>VisualDuplicate +1<CR>", { desc = "Duplication" })

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

-- TODO: move to a function named customise keymapings
if vim.g.neovide then
  vim.keymap.set("n", "<D-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })
  vim.keymap.set(
    "n",
    "<D-e>",
    "<cmd>Telescope frecency workspace=CWD<cr>",
    { desc = "FindRecentFiles" }
  )
  map("n", "<C-D-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
  map("n", "<C-D-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
  vim.keymap.set("n", "<D-k><D-k>", "<cmd>Lspsaga code_action<cr>", { desc = "CodeActions" })
end

neovideMacCopy()
