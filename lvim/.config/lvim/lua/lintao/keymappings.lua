local command_keymappings = {
  ['FindCommands'] = '<C-M-p>',
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
}

local function unmapLvimDefault()
  lvim.keys.normal_mode["<M-w>"] = false

  lvim.builtin.which_key.mappings['w'] = {}
  lvim.builtin.which_key.mappings['f'] = {}
  lvim.builtin.which_key.mappings['<leader>f'] = {}
end

unmapLvimDefault()
for command, keybinding in pairs(command_keymappings) do
  if type(keybinding == 'string') then
    lvim.keys.normal_mode[keybinding] = "<CMD>" .. command .. "<CR>"
    goto continue
  end

  if keybinding.mode == 'v' then
    lvim.keys.visual_mode[keybinding.keys] = "<CMD>" .. command .. "<CR>"
  end
  ::continue::
end

lvim.keys.normal_mode["<leader>wo"] = { "<c-w>o", desc = "Maximize window" }
