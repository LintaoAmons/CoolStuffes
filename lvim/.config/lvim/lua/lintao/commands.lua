local function unmapLvimDefault()
  lvim.keys.normal_mode["<M-w>"] = false

  lvim.builtin.which_key.mappings['w'] = {}
  lvim.builtin.which_key.mappings['f'] = {}
  lvim.builtin.which_key.mappings['<leader>f'] = {}
end

local commands_name = require("lintao.commands-name")

local commands_implementation = {
  {
    name = commands_name.navigation.BufferPrev,
    callback = "BufferLineCyclePrev",
    keybinding = {
      mode = 'n',
      keys = '<S-h>'

    }
  },
  {
    name = commands_name.navigation.BufferNext,
    callback = "BufferLineCycleNext",
    keybinding = {
      mode = 'n',
      keys = '<S-l>'

    }
  },
  {
    name = commands_name.navigation.TabPrev,
    callback = "tabprevious",
    keybinding = {
      mode = 'n',
      keys = 'th'

    }
  },
  {
    name = commands_name.navigation.TabNext,
    callback = "tabnext",
    keybinding = {
      mode = 'n',
      keys = 'tl'

    }
  },
  {
    name = commands_name.navigation.TabClose,
    callback = "tabclose",
    keybinding = {
      mode = 'n',
      keys = 'tt'

    }
  },
  {
    name = commands_name.navigation.TabNew,
    callback = "tabnew",
    keybinding = {
      mode = 'n',
      keys = 'tn'

    }
  },
  {
    name = commands_name.navigation.MaximiseBuffer,
    callback = 'lua require("lintao.command-functions").MaximiseBuffer()',
  },
  -- {
  --   name = commands_name.navigation.LeapJump,
  --   callback = 'lua require("lintao.command-functions").search_ref()'
  -- },
  {
    name = commands_name.git.GitPush,
    callback = 'Git push'
  },
  {
    name = commands_name.git.GitStash,
    callback = 'Git stash'
  },
  {
    name = commands_name.navigation.OpenRecentFiles,
    callback = 'FzfLua oldfiles'
  },
  {
    name = commands_name.test.GoToTestFile,
    callback = 'lua require("lintao.command-functions").GoToTestFile()',
    keybinding = {
      mode = 'n',
      keys = 'gt',
    }
  },
  {
    name = commands_name.other.CloseWindowOrBuffer,
    callback = 'lua require("lintao.command-functions").closeWindowOrBuffer()',
    keybinding = {
      mode = 'n',
      keys = '<M-w>'
    }
  },
  {
    name = commands_name.navigation.OpenChangedFiles,
    callback = "FzfLua git_status",
    keybinding = {
      mode = 'n',
      keys = '<M-e>'
    }
  },
  {
    name = commands_name.git.GitDiff,
    callback = "DiffviewOpen",
    keybinding = {
      mode = "n",
      keys = "<leader>df",
    }
  },
  {
    name = commands_name.git.GitCommit,
    callback = 'lua require("lintao.command-functions").stashAndCommit()',
    keybinding = {
      mode = 'n',
      keys = '<leader>ge',
    }
  },
  {
    name = commands_name.git.GitListCommits,
    callback = "DiffviewFileHistory",
    keybinding = {
      mode = 'n',
      keys = '<leader>gh',
    }
  },
  {
    name = commands_name.git.GitListCurrentFileCommits,
    callback = "DiffviewFileHistory %",
    keybinding = {
      mode = 'n',
      keys = '<leader>gf'
    }
  },
  {
    name = commands_name.git.GitNextHunk,
    callback = "lua require 'gitsigns'.next_hunk({navigation_message = false})",
    keybinding = {
      mode = 'n',
      keys = 'gj'
    }
  },
  {
    name = commands_name.git.GitPrevHunk,
    callback = "lua require 'gitsigns'.prev_hunk({navigation_message = false})",
    keybinding = {
      mode = 'n',
      keys = 'gk'
    }
  },
  {
    name = commands_name.git.GitListBranches,
    callback = "FzfLua git_branches"
  },
  {
    name = commands_name.git.GitChangedFiles,
    callback = "FzfLua git_status"
  },
  {
    name = commands_name.explorer.ExplorerLocateCurrentFile,
    callback = "NvimTreeFocus",
    keybinding = {
      mode = 'n',
      keys = '<leader>fl'
    }
  },
  {
    name = commands_name.test.TestDebugNearest,
    callback = 'lua require("dap-go").debug_test()'
  },
  {
    name = commands_name.test.TestRunNearest,
    callback = 'lua require("neotest").run.run()'
  },
  {
    name = commands_name.test.TestOutputPanel,
    callback = 'lua require("neotest").output_panel.open()'
  },
  {
    name = commands_name.finder.FindFiles,
    callback = 'FzfLua files',
    keybinding = {
      mode = 'n',
      keys = '<C-p>'
    }
  },
  {
    name = commands_name.finder.FindCommands,
    callback = 'FzfLua commands',
    keybinding = {
      mode = 'n',
      keys = '<C-M-p>'
    }
  },
  {
    name = commands_name.finder.FindKeymappins,
    callback = 'FzfLua keymaps',
  },
  {
    name = commands_name.finder.FzfLuaBuiltin,
    callback = 'lua require("fzf-lua").builtin()'
  },
  {
    name       = commands_name.finder.FindInWholeProject,
    callback   = 'FzfLua grep_project',
    keybinding = {
      mode = 'n',
      keys = '<C-f>'
    }
  },
  {
    name = commands_name.other.CopyBufferAbsolutePath,
    callback = 'lua require("lintao.command-functions").copyBufferAbsolutePath()'
  },
  {
    name = commands_name.other.CopyBufferDirectoryPath,
    callback = 'lua require("lintao.command-functions").copyBufferDirectoryPath()'
  }
}

local function register_commands_and_keybinding(commands)
  for _, v in ipairs(commands) do
    -- print(v.name)
    vim.api.nvim_create_user_command(v.name, v.callback, {})

    if v.keybinding then
      if v.keybinding.mode == "n" then
        lvim.keys.normal_mode[v.keybinding.keys] = "<CMD>" .. v.callback .. "<CR>"
      elseif v.keybinding.mode == "v" then
        lvim.keys.visual_mode[v.keybinding.keys] = "<CMD>" .. v.callback .. "<CR>"
      end
    end
  end
end

local function init_default_behaviour(all_commands)
  for _, v in pairs(all_commands) do
    if type(v) == "table" then
      init_default_behaviour(v)
    else
      vim.api.nvim_create_user_command(v, "echo 'Not implemented yet'", {})
    end
  end
end

unmapLvimDefault()
init_default_behaviour(commands_name)
register_commands_and_keybinding(commands_implementation)
