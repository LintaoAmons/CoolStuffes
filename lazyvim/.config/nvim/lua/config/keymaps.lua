-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.del("n", "<leader>l", {})
vim.keymap.del({ "n", "i", "v" }, "<A-j>", {})
vim.keymap.del({ "n", "i", "v" }, "<A-k>", {})

local command_keymappings = {
  -- HACK: Debug
  ["DebugToggleUI"] = "<M-5>",
  ["DebugStart"] = "<F5>",
  ["DebugToggleBreakpoint"] = "<F9>",
  ["DebugStepOver"] = "<F8>",
  ["DebugStepInto"] = "<F7>",
  ["DebugStop"] = "<M-F2>",

  -- HACK: DB
  ["DBUIToggle"] = "<M-C-9>",

  -- ["SearchSession"] = "<C-q>",
  ["PeekDefinition"] = "<M-k>k",
  ["PeekTypeDefinition"] = "<M-k>l",
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
  ["OpenRecentFiles"] = "<M-e>",
  ["NoHighlight"] = "<leader>nl",
  ["FormatCode"] = "<leader>fm",
  ["QuitNvim"] = "<M-q>",
  ["CloseWindowOrBuffer"] = "<M-w>",
  ["SplitVertically"] = "<leader>wl",
  ["DecreaseSplitWidth"] = "<C-M-j>",
  ["IncreaseSplitWidth"] = "<C-M-k>",
  ["ToggleOutline"] = "<leader>ss",
  ["ToggleLf"] = "<leader>oo",
  ["RunCurrentBuffer"] = "<M-r>",
  ["Scratch"] = "<M-C-n>",
  ["ScratchOpen"] = "<M-C-o>",
  ["FindInProject"] = { mode = "nv", keys = "<C-f>" },
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
  ["CodeActions"] = "<M-k><M-k>",
  ["LspFinder"] = "<M-k>f",
  -- ["ExtractVariable"] = "<leader>ev",

  -- ["Mark"] = "m",
  -- ["MarkList"] = "<C-M-i>",
  ["ToNextCase"] = { mode = "nv", keys = "<leader>nc" },
}

local function contains(str, char)
  for i = 1, #str do
    if str:sub(i, i) == char then
      return true
    end
  end
  return false
end

for command, keybinding in pairs(command_keymappings) do
  if type(keybinding) == "string" then
    vim.keymap.set("n", keybinding, "<CMD>" .. command .. "<CR>", {})
    goto continue
  end

  if contains(keybinding.mode, "v") then
    vim.keymap.set("v", keybinding.keys, "<CMD>" .. command .. "<CR>", {})
  end

  if contains(keybinding.mode, "n") then
    vim.keymap.set("n", keybinding.keys, "<CMD>" .. command .. "<CR>", {})
  end

  if contains(keybinding.mode, "i") then
    vim.keymap.set("i", keybinding.keys, "<CMD>" .. command .. "<CR>", {})
  end

  ::continue::
end
vim.keymap.set("n", "<leader>wo", "<c-w>o", { desc = "Maximize window" })

-- TODO: Move to easy-commands
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local Util = require("lazyvim.util")
local lazyterm = function()
  Util.float_term(nil, { cwd = Util.get_root() })
end
map("n", "<c-\\>", lazyterm, { desc = "Terminal (root dir)" })
map("t", "<C-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.keymap.set("v", "p", "P")

-- explorer
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })
vim.keymap.set("n", "<leader>fl", "<cmd>Neotree reveal<cr>", { desc = "ExplorerFindFileLocation" })

vim.keymap.set("n", "<M-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })
-- TODO: issue raise
-- vim.keymap.set("n", "gm", function()
--   require("syntax-tree-surfer").go_to_top_node_and_execute_commands(false, { "normal! w" })
-- end, { silent = true, expr = true })
