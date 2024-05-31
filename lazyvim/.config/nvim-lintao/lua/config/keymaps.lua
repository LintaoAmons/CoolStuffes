-- don't overwrite the clipboard
vim.keymap.set("v", "p", "P")

-- explorer
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>fl", "<cmd>Neotree reveal reveal_force_cwd<cr>", { desc = "ExplorerFindFileLocation" })
vim.keymap.set("n", "<M-1>", "<cmd>Neotree toggle<cr>", { desc = "ExplorerToggle" })

vim.keymap.set("n", "<M-e>", "<cmd>Telescope frecency<cr>", { desc = "FindRecentFiles" })
vim.keymap.set({ "n", "v" }, "<M-k><M-k>", "<cmd>Lspsaga code_action<cr>", { desc = "CodeActions" })
vim.keymap.set({ "i", "v", "t" }, "jk", [[<C-\><C-n>]], { buffer = 0 })

vim.keymap.set("n", "<leader>ss", "<cmd>Lspsaga outline<cr>", { desc = "ToggleOutline" })
vim.keymap.set("v", "<C-M-j>", "<CMD>VisualDuplicate +1<CR>", { desc = "Duplication" })

-- diagnostic
vim.keymap.set("n", "<leader>sd", "<CMD>Lspsaga show_diagnostics<CR>", { desc = "show_diagnostics" })

vim.keymap.set("n", "<C-M-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-M-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })

vim.keymap.set("n", "<leader>e", ":Triptych<CR>", { silent = true })
vim.keymap.set("n", "<C-i>", ":Telescope toggleterm_manager<CR>", { silent = true })

local command_keymappings = {
	["BookmarksGotoRecent"] = { modes = "n,v", keys = "mg" },
	["BookmarksMark"] = "mm",
	["BookmarksCommands"] = "ma",
	["BookmarksGoto"] = "mo",
	["ObsidianQuickSwitch"] = "<leader>nf", -- note finder

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

	["SendSelectedToTerminalAndRun"] = { modes = "n,v", keys = "<leader>sk" },
	["SendLineToTerminalAndRun"] = { modes = "n,v", keys = "<leader>sl" },
	["RunCurrentBuffer"] = "<M-r>",
	["RunShellAtBufDir"] = { modes = "n,v", keys = "<leader>rk" },
	["RunShellCurrentLine"] = { modes = "n,v", keys = "<leader>rl" },
	["MaximiseWindowAsPopup"] = { modes = "n,v", keys = "<leader>wp" },
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

