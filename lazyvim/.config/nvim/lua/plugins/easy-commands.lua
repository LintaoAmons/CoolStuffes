return {
  -- "LintaoAmons/easy-commands.nvim",
  dir = vim.loop.os_homedir() .. "/Documents/oatnil/beta/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").Setup({
      -- disabledCommands = { "CopyFilename", "FormatCode" },
      myCommands = {
        ["MyCommand"] = "lua vim.print('easy command user command')",
        ["EasyCommand"] = "lua vim.print('Over write easy-command builtin command')",
        ["CopyCdCommand"] = function()
          local editor = require("easy-commands.impl.util.editor")
          local cmd = "cd " .. editor.get_buf_abs_dir_path()
          vim.print(cmd)
          require("easy-commands.impl.util.base.sys").CopyToSystemClipboard(cmd)
        end,
        ["NewFile"] = function()
          vim.cmd("NvimTreeFindFile")
          vim.cmd("norm a")
        end,
      },
      ["RunSelectedAndOutputWithPrePostFix"] = {
        prefix = "```lua",
        postfix = "```",
      },
    })
  end,
}
