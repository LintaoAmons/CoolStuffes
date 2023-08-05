return {
  {
    "LintaoAmons/easy-commands.nvim",
    event = "VeryLazy",
    config = function()
      require("easy-commands").setup({
        disabledCommands = { "CopyFilename" }, -- You can disable the commands you don't want

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
        },
      })
    end,
  },
}
