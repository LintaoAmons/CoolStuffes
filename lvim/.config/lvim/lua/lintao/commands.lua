local git_commands = {
  {
    name = "GitDiff",
    callback = "DiffviewOpen",
    keybinding = {
      mode = "n",
      keys = "<leader>df",
    }
  },
  {
    name = "GitCommit",
    callback = "Git commit",
    keybinding = {
      mode = 'n',
      keys = '<leader>ge',
    }
  },
  {
    name = "GitListCommits",
    callback = "DiffviewFileHistory",
    keybinding = {
      mode = 'n',
      keys = '<leader>gh',
    }
  },
  {
    name = "GitListCurrentFileCommits",
    callback = "DiffviewFileHistory %",
    keybinding = {
      mode = 'n',
      keys = '<leader>gf'
    }
  },
  {
    name = "GitNextHunk",
    callback = "lua require 'gitsigns'.next_hunk({navigation_message = false})",
    keybinding = {
      mode = 'n',
      keys = 'gj'
    }
  },
  {
    name = "GitPrevHunk",
    callback = "lua require 'gitsigns'.prev_hunk({navigation_message = false})",
    keybinding = {
      mode = 'n',
      keys = 'gk'
    }
  },
  {
    name = "GitListBranches",
    callback = "FzfLua git_branches"
  }
}

local other_commands = { {
  name = "FzfLuaBuiltin",
  callback = 'lua require("fzf-lua").builtin()'
} }

local function register_commands_and_keybinding(commands)
  for _, v in ipairs(commands) do
    vim.api.nvim_create_user_command(v.name, v.callback, {})

    if v.keybinding then
      if v.keybinding.mode == "n" then
        print("configuring " .. v.name)
        lvim.keys.normal_mode[v.keybinding.keys] = "<CMD>" .. v.callback .. "<CR>"
      elseif v.keybinding.mode == "v" then
        lvim.keys.visual_mode[v.keybinding.keys] = "<CMD>" .. v.callback .. "<CR>"
      end
    end
  end
end

register_commands_and_keybinding(other_commands)
register_commands_and_keybinding(git_commands)
