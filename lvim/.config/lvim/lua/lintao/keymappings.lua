local command_keymappings = {
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
  ['DecreaseSplitWidth'] = '<C-M-k>',
  ['IncreaseSplitWidth'] = '<C-M-j>',
  ['ToggleOutline'] = '<leader>ss',
  ['RunCurrentBuffer'] = '<M-r>',
  ['Scratch'] = '<M-C-n>',
  ['ScratchOpen'] = '<M-C-o>',
  ['FindInWholeProject'] = '<C-f>',
  ['GitNextHunk'] = 'gj',
  ['GitPrevHunk'] = 'gk',
  ['GitDiff'] = '<leader>df',
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
}

local function unmapLvimDefault()
  lvim.keys.normal_mode["<M-w>"] = false

  lvim.builtin.which_key.mappings['w'] = {}
  lvim.builtin.which_key.mappings['f'] = {}
  lvim.builtin.which_key.mappings['<leader>f'] = {}
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

  if contains(keybinding.mode ,'v') then
  lvim.keys.visual_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end

  if contains(keybinding.mode ,'n') then
  lvim.keys.normal_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end

  if contains(keybinding.mode ,'i') then
  lvim.keys.insert_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end

  ::continue::
end

lvim.keys.normal_mode["<leader>wo"] = { "<c-w>o", desc = "Maximize window" }
-- lvim.keys.visual_mode["p"] = {'"_dp'} -- HACK: keep the clipboard unchanged when replace the selected with clipboard
