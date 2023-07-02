return {
  -- dir = "/Users/lintao.zhang/Documents/oatnil/release/easy-commands.nvim",
  -- "LintaoAmons/easy-commands.nvim",
  dir = vim.loop.os_homedir() .. "/Documents/oatnil/beta/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").Setup({
      ["RunSelectedAndOutputWithPrePostFix"] = {
        prefix = "```lua",
        postfix = "```",
      },
    })
  end,
}
