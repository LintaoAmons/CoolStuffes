return {
  "LintaoAmons/easy-commands.nvim",
  -- dir = vim.loop.os_homedir() .. "/Documents/oatnil/beta/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").setup({
      disabledCommands = { "Git", "CopyFilename" }, -- You can disable the commands you don't want
      -- It always welcome to send me back your good commands and usecases
      ---@type EasyCommand.Command[]
      myCommands = {
        -- You can add your own commands
        {
          name = "MyCommand",
          callback = 'lua vim.print("easy command user command")',
          description = "A demo command definition",
        },
        -- You can overwrite the current implementation
        {
          name = "EasyCommand",
          callback = 'lua vim.print("Overwrite easy-command builtin command")',
          description = "The default implementation is overwrited",
        },
        -- You can use the utils provided by the plugin to build your own command
        {
          name = "CopyCdCommand",
          callback = function()
            local editor = require("easy-commands.impl.util.editor")
            local cmd = "cd " .. editor.get_buf_abs_dir_path()
            vim.print(cmd)
            require("easy-commands.impl.util.base.sys").CopyToSystemClipboard(cmd)
          end,
          description = "Copy the buffer abs path to system clipboard",
        },
        {
          name = "CodeActions",
          callback = "Lspsaga code_action",
        },
        {
          name = "DistinctLines",
          callback = "sort u",
        },
        {
          name = "TrimLine",
          callback = function()
            local line = vim.api.nvim_get_current_line()
            local trimmed = string.match(line, "^%s*(.-)%s*$")
            vim.api.nvim_set_current_line(trimmed)
          end,
        },
        {
          name = "JoinLines",
          callback = "'<,'>s/\v\n/,/",
        },
        {
          name = "AskGpt4",
          callback = function()
            require("scratch").scratchByType("gp4.md")
          end,
          dependencies = {
            "https://github.com/robitx/gp.nvim",
            "https://github.com/LintaoAmons/scratch.nvim",
          },
          description = "Ask chatgpt in vim and stored in scratchfile's directory",
        },
        {
          name = "OpenInFinder",
          description = "Open the directory of current file in finder",
          callback = function()
            local dirpath = require("easy-commands.impl.util.editor").get_buf_abs_dir_path()
            vim.cmd("!open " .. dirpath)
          end,
        },
        {
          name = "OpenBySystemDefaultApp",
          description = "Open the current file by system default app",
          callback = function()
            local abspath = require("easy-commands.impl.util.editor").get_buf_abs_path()
            vim.cmd("!open " .. abspath)
          end,
        },
      },

      aliases = {
        {
          from = "GitListCommits",
          to = "GitLog",
        },
      },

      -- Each Command may have defferent config options, check out the commands to find more options.
      ["RunSelectedAndOutputWithPrePostFix"] = {
        prefix = "```lua",
        postfix = "```",
      },
    })
  end,
}
