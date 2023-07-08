return {
  "LintaoAmons/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").Setup({
      -- disabledCommands = { "CopyFilename", "FormatCode" },
      myCommands = {
        ["MyCommand"] = "lua vim.print('easy command user command')",
        ["EasyCommand"] = "lua vim.print('Over write easy-command builtin command')",
      },
      ["RunSelectedAndOutputWithPrePostFix"] = {
        prefix = "```lua",
        postfix = "```",
      },
    })
  end,
}
