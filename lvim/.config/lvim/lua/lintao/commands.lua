local function unmapLvimDefault()
  lvim.keys.normal_mode["<M-w>"] = false

  lvim.builtin.which_key.mappings['w'] = {}
  lvim.builtin.which_key.mappings['f'] = {}
  lvim.builtin.which_key.mappings['<leader>f'] = {}
end

local commands_name = require("lintao.commands-name")

local commands_implementation = {
  -- [commands_name.refactor.ToSnakeCase] = {
  --   callback = 'lua require("lintao.command-functions").toSnakeCase()',
  --   allow_visual_mode = true,
  -- },
  -- [commands_name.refactor.ToKebabCase] = {
  --   callback = 'lua require("lintao.command-functions").toKebabCase()',
  --   allow_visual_mode = true,
  -- },
  -- [commands_name.refactor.ToConstantCase] =
  -- {
  --   callback = 'lua require("lintao.command-functions").toConstantCase()',
  --   allow_visual_mode = true,
  -- },
  -- [commands_name.refactor.ToCamelCase] =
  -- {
  --   callback = 'lua require("lintao.command-functions").toCamelCase()',
  --   allow_visual_mode = true,
  -- },

  [commands_name.navigation.MarkPrev] =
  {
    callback = "lua require('harpoon.ui').nav_prev()",
    keybinding = {
      mode = "n",
      keys = '<M-C-h>',
    }
  },
  [commands_name.navigation.MarkNext] =
  {
    callback = "lua require('harpoon.ui').nav_next()",
    keybinding = {
      mode = "n",
      keys = '<M-C-l>',
    }
  },

  -- [commands_name.refactor.InlineVariable] =
  -- {
  --   callback = "lua require('refactoring').refactor('Inline Variable')",
  -- },
  -- [commands_name.refactor.ExtractVariable] =
  -- {
  --   callback = "lua require('refactoring').refactor('Extract Variable')",
  --   keybinding = {
  --     mode = "n",
  --     keys = '<leader>ev',
  --   }
  -- },
  -- [commands_name.refactor.ExtractFunction] =
  -- {
  --   callback = "lua require('refactoring').refactor('Extract Function')",
  --   keybinding = {
  --     mode = "n",
  --     keys = '<leader>em',
  --   }
  -- },

  -- [commands_name.navigation.MarkJump] =
  -- {
  --   callback = 'Telescope harpoon marks',
  --   keybinding = {
  --     mode = "n",
  --     keys = '<C-M-i>',
  --   }
  -- },
  -- [commands_name.navigation.Mark] =
  -- {
  --   callback = 'lua require("harpoon.mark").add_file()',
  --   keybinding = {
  --     mode = 'n',
  --     keys = 'm'
  --   }
  -- },
  [commands_name.navigation.DecreaseSplitWidth] =
  {
    callback = 'vertical resize -5',
    keybinding = {
      mode = "n",
      keys = '<C-M-k>',
    }
  },
  [commands_name.navigation.IncreaseSplitWidth] =
  {
    callback = 'vertical resize +5',
    keybinding = {
      mode = "n",
      keys = '<C-M-j>',
    }
  },
  -- { TODO: Why notCmd not working
  --   name = commands_name.navigation.MaximiseBufferAndCloseOthers,
  --   notCmd = true,
  --   callback = '<c-w>o',
  --   keybinding = {
  --     mode = "n",
  --     keys = '<leader>wo',
  --   }
  -- },
  [commands_name.navigation.SplitVertically] =
  {
    callback = 'vsplit',
    keybinding = {
      mode = "n",
      keys = '<leader>wl',
    }
  },
  [commands_name.nvim.SourceCurrentBuffer] =
  {
    callback = 'luafile %',
  },
  [commands_name.other.ToggleOutline] =
  {
    callback = 'AerialToggle',
    keybinding = {
      mode = "n",
      keys = '<leader>ss',
    }
  },
  [commands_name.other.NoHighlight] =
  {
    callback = 'nohl',
    keybinding = {
      mode = "n",
      keys = '<leader>nl',
    }
  },
  [commands_name.other.FormatCode] =
  {
    callback = 'lua vim.lsp.buf.format { async = true }',
    keybinding = {
      mode = "n",
      keys = '<leader>fm',
    }
  },
  [commands_name.run.RunLiveToggle] =
  {
    callback = 'SnipLive',
    keybinding = {
      mode = "n",
      keys = '<M-r>',
    }
  },
  [commands_name.run.RunCurrentBuffer] =
  {
    callback = '%SnipRun',
    keybinding = {
      mode = "n",
      keys = '<M-r>',
    }
  },
  [commands_name.other.QuitNvim] =
  {
    callback = 'qa!',
    keybinding = {
      mode = "n",
      keys = '<M-q>',
    }
  },
  [commands_name.git.GitResetHunk] =
  {
    callback = 'lua require("gitsigns").reset_hunk()',
    keybinding = {
      mode = "n",
      keys = '<leader>rl',
    }
  },
  [commands_name.scratch.ScratchOpen] =
  {
    callback = "ScratchOpen",
    keybinding = {
      mode = 'n',
      keys = '<M-C-o>'
    }
  },
  [commands_name.scratch.Scratch] =
  {
    callback = "Scratch",
    keybinding = {
      mode = 'n',
      keys = '<M-C-n>'
    }
  },
  -- [commands_name.navigation.BufferPrev] =
  -- {
  --   callback = "BufferLineCyclePrev",
  --   keybinding = {
  --     mode = 'n',
  --     keys = '<S-h>'

  --   }
  -- },
  -- [commands_name.navigation.BufferNext] =
  -- {
  --   callback = "BufferLineCycleNext",
  --   keybinding = {
  --     mode = 'n',
  --     keys = '<S-l>'

  --   }
  -- },
  -- [commands_name.navigation.TabPrev] =
  -- {
  --   callback = "tabprevious",
  --   keybinding = {
  --     mode = 'n',
  --     keys = 'th'

  --   }
  -- },
  -- [commands_name.navigation.TabNext] =
  -- {
  --   callback = "tabnext",
  --   keybinding = {
  --     mode = 'n',
  --     keys = 'tl'

  --   }
  -- },
  -- [commands_name.navigation.TabClose] =
  -- {
  --   callback = "tabclose",
  --   keybinding = {
  --     mode = 'n',
  --     keys = 'tt'

  --   }
  -- },
  -- [commands_name.navigation.TabNew] =
  -- {
  --   callback = "tabnew",
  --   keybinding = {
  --     mode = 'n',
  --     keys = 'tn'
  --   }
  -- },
  -- [commands_name.navigation.MaximiseBuffer] =
  -- {
  --   callback = 'lua require("lintao.command-functions").MaximiseBuffer()',
  -- },
  -- [commands_name.navigation.LeapJump] =
  -- {
  --   callback = 'lua require("lintao.command-functions").LeapJump()',
  --   keybinding = {
  --     mode = 'n',
  --     keys = 's'
  --   }
  -- },
  [commands_name.git.GitPush] =
  {
    callback = 'Git push'
  },
  [commands_name.git.GitStash] =
  {
    callback = 'Git stash'
  },
  [commands_name.navigation.OpenRecentFiles] =
  {
    callback = 'FzfLua oldfiles'
  },
  [commands_name.test.TestToggleOutputPanel] =
  {
    callback = 'lua require("neotest").output_panel.toggle()',
  },
  [commands_name.test.TestRunCurrentFile] =
  {
    callback = 'lua require("neotest").run.run(vim.fn.expand("%"))',
  },
  [commands_name.test.TestRunLast] =
  {
    callback = 'lua require("neotest").run.run_last()',
  },
  [commands_name.test.GoToTestFile] =
  {
    callback = 'lua require("lintao.command-functions").GoToTestFile()',
    keybinding = {
      mode = 'n',
      keys = 'gt',
    }
  },
  [commands_name.other.CloseWindowOrBuffer] =
  {
    callback = 'lua require("lintao.command-functions").closeWindowOrBuffer()',
    keybinding = {
      mode = 'n',
      keys = '<M-w>'
    }
  },
  -- [commands_name.navigation.OpenChangedFiles] =
  -- {
  --   callback = "FzfLua git_status",
  --   keybinding = {
  --     mode = 'n',
  --     keys = '<M-e>'
  --   }
  -- },
  [commands_name.git.GitDiff] =
  {
    callback = "DiffviewOpen",
    keybinding = {
      mode = "n",
      keys = "<leader>df",
    }
  },
  [commands_name.git.GitCommit] =
  {
    callback = 'lua require("lintao.command-functions").stashAndCommit()',
    keybinding = {
      mode = 'n',
      keys = '<leader>ge',
    }
  },
  [commands_name.git.GitListCommits] =
  {
    callback = "DiffviewFileHistory",
    keybinding = {
      mode = 'n',
      keys = '<leader>gh',
    }
  },
  [commands_name.git.GitListCurrentFileCommits] =
  {
    callback = "DiffviewFileHistory %",
    keybinding = {
      mode = 'n',
      keys = '<leader>gf'
    }
  },
  [commands_name.git.GitNextHunk] =
  {
    callback = "lua require 'gitsigns'.next_hunk({navigation_message = false})",
    keybinding = {
      mode = 'n',
      keys = 'gj'
    }
  },
  [commands_name.git.GitPrevHunk] =
  {
    callback = "lua require 'gitsigns'.prev_hunk({navigation_message = false})",
    keybinding = {
      mode = 'n',
      keys = 'gk'
    }
  },
  [commands_name.git.GitListBranches] =
  {
    callback = "FzfLua git_branches"
  },
  [commands_name.git.GitChangedFiles] =
  {
    callback = "FzfLua git_status"
  },
  [commands_name.explorer.ExplorerLocateCurrentFile] =
  {
    callback = "NvimTreeFocus",
    keybinding = {
      mode = 'n',
      keys = '<leader>fl'
    }
  },
  [commands_name.test.TestDebugNearest] =
  {
    callback = 'lua require("dap-go").debug_test()'
  },
  [commands_name.test.TestRunNearest] =
  {
    callback = 'lua require("neotest").run.run()',
    keybinding = {
      mode = 'n',
      keys = '<leader>rt'
    }
  },
  [commands_name.test.TestOutputPanel] =
  {
    callback = 'lua require("neotest").output_panel.open()'
  },
  -- [commands_name.finder.FindFiles] =
  -- {
  --   callback = 'FzfLua files',
  --   keybinding = {
  --     mode = 'n',
  --     keys = '<C-p>'
  --   }
  -- },
  -- [commands_name.finder.FindCommands] =
  -- {
  --   callback = 'FzfLua commands',
  --   keybinding = {
  --     mode = 'n',
  --     keys = '<C-M-p>'
  --   }
  -- },
  -- [commands_name.finder.FindKeymappins] =
  -- {
  --   callback = 'FzfLua keymaps',
  -- },
  -- [commands_name.finder.FzfLuaBuiltin] =
  -- {
  --   callback = 'lua require("fzf-lua").builtin()'
  -- },
  -- [commands_name.finder.FindInWholeProject] =
  -- {
  --   callback   = 'FzfLua grep_project',
  --   keybinding = {
  --     mode = 'n',
  --     keys = '<C-f>'
  --   }
  -- },
  -- [commands_name.other.CopyProjectDir] =
  -- {
  --   callback = 'lua require("lintao.command-functions").copyProjectDir()'
  -- },
  -- [commands_name.other.CopyBufRelativePath] =
  -- {
  --   callback = 'lua require("lintao.command-functions").CopyBufRelativePath()'
  -- },
  -- [commands_name.other.CopyBufRelativeDirPath] =
  -- {
  --   callback = 'lua require("lintao.command-functions").CopyBufRelativeDirPath()'
  -- },
  -- [commands_name.other.CopyBufAbsPath] =
  -- {
  --   callback = 'lua require("lintao.command-functions").copyBufferAbsolutePath()'
  -- },
  -- [commands_name.other.CopyBufAbsDirPath] =
  -- {
  --   callback = 'lua require("lintao.command-functions").copyBufferDirectoryPath()'
  -- }
}

local function register_commands_and_keybinding(commands)
  for k, v in pairs(commands) do
    -- print(v.name)
    if v.allow_visual_mode then
      -- https://github.com/ray-x/go.nvim/blob/711b3b84cf59d3c43a9d1b02fdf12152b397e7b1/lua/go/commands.lua#LL443C7-L443C20
      vim.api.nvim_create_user_command(k, v.callback, { range = true })
    else
      vim.api.nvim_create_user_command(k, v.callback, {})
    end

    if v.keybinding then
      if v.keybinding.mode == "n" then
        -- if v.notCmd then
        --   print(v.name)
        --   print("NotCmd")
        --   print(v.keybinding.keys)
        --   print(v.callback)
        --   -- lvim.keys.normal_mode[v.keybinding.keys] = { v.callback, desc = "Maximize window" }
        --   vim.api.nvim_set_keymap('n', "<leader>wo", '<c-w>o', {noremap = true})
        -- end
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
lvim.keys.normal_mode["<leader>wo"] = { "<c-w>o", desc = "Maximize window" }
lvim.keys.normal_mode["<leader>zo"] = { "zR", desc = "Unfold all" }
lvim.keys.normal_mode["<leader>zc"] = { "zM", desc = "Fold all" }
