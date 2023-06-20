local command_keymappings = {
  ['SwitchProject'] = '<C-q>',
  ['LeapJump'] = 's',
  ['FindCommands'] = {
    mode = 'niv',
    keys = '<C-M-p>'
  },
  ['FindFiles'] = '<C-p>',
  ['OpenRecentFiles'] = '<M-e>',
  ['NoHighlight'] = '<leader>nl',
  ['FormatCode'] = '<leader>fm',
  ['QuitNvim'] = '<M-q>',
  ['CloseWindowOrBuffer'] = '<M-w>',
  ['SplitVertically'] = '<leader>wl',
  ['DecreaseSplitWidth'] = '<C-M-h>',
  ['IncreaseSplitWidth'] = '<C-M-l>',
  ['ToggleOutline'] = '<leader>ss',
  ['RunCurrentBuffer'] = '<M-r>',
  ['Scratch'] = '<M-C-n>',
  ['ScratchOpen'] = '<M-C-o>',
  ['FindInWholeProject'] = '<C-f>',

  -- HACK: GIT
  ['GitNextHunk'] = 'gj',
  ['GitPrevHunk'] = 'gk',
  ['GitDiff'] = '<leader>df',
  ['GitStatus'] = '<leader>gs',
  ['GitLazygit'] = '<leader>gg',
  ['BlameLine'] = '<leader>gl',


  ['BufferPrev'] = '<S-h>',
  ['BufferNext'] = '<S-l>',
  ['TabClose'] = "tt",
  ['TabPrev'] = 'th',
  ['TabNext'] = 'tl',
  ['ExplorerLocateCurrentFile'] = "<leader>fl",
  ['GoToTestFile'] = 'gt',
  ['TestRunNearest'] = '<leader>rt',
  ['GoToDefinition'] = "gd",
  ['LspFinder'] = "gf",
  ['ExtractVariable'] = '<leader>ev',

  ['Mark'] = 'm',
  ['MarkList'] = "<C-M-i>",

  ['ToNextCase'] = {
    mode = 'nv',
    keys = "<leader>nc"
  },
}

local function unmapLvimDefault()
  lvim.keys.normal_mode["<M-w>"] = false
  lvim.keys.normal_mode["<leader>gs"] = false

  lvim.builtin.which_key.mappings['w'] = {}
  lvim.builtin.which_key.mappings['f'] = {}
  lvim.builtin.which_key.mappings['<leader>f'] = {}
  lvim.builtin.which_key.mappings['g'] = {}
  lvim.builtin.which_key.mappings['q'] = {}
end

local function contains(str, char)
  for i = 1, #str do
    if str:sub(i, i) == char then
      return true
    end
  end
  return false
end

unmapLvimDefault()
for command, keybinding in pairs(command_keymappings) do
  if type(keybinding) == 'string' then
    lvim.keys.normal_mode[keybinding] = "<CMD>" .. command .. "<CR>"
    goto continue
  end

  if contains(keybinding.mode, 'v') then
    lvim.keys.visual_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end

  if contains(keybinding.mode, 'n') then
    lvim.keys.normal_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end

  if contains(keybinding.mode, 'i') then
    lvim.keys.insert_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end

  ::continue::
end

lvim.keys.normal_mode["<leader>wo"] = { "<c-w>o", desc = "Maximize window" }

-- HACK: `uo` to exit terminal insert mode
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', 'uo', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
