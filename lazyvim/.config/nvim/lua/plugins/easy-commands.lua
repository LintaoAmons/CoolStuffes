return {
  "LintaoAmons/easy-commands.nvim",
  -- dir = vim.loop.os_homedir() .. "/Documents/oatnil/beta/easy-commands.nvim",
  event = "VeryLazy",
  config = function()
    require("easy-commands").Setup({
      -- disabledCommands = { "CopyFilename", "FormatCode" },
      myCommands = {
        ["MyCommand"] = "lua vim.print('easy command user command')",
        ["EasyCommand"] = "lua vim.print('Over write easy-command builtin command')",
        ["Git"] = "Neogit",
        ["GitPeek"] = "Gitsigns preview_hunk",
        ["CopyCdCommand"] = function()
          local editor = require("easy-commands.impl.util.editor")
          local cmd = "cd " .. editor.get_buf_abs_dir_path()
          vim.print(cmd)
          require("easy-commands.impl.util.base.sys").CopyToSystemClipboard(cmd)
        end,
        ["GoCopyTest"] = function()
          local editor = require("easy-commands.impl.util.editor")
          local sys = require("easy-commands.impl.util.base.sys")

          local filepath = editor.get_buf_abs_path()
          local testName = editor.getSelectedText()
          local cmd = "go test " .. filepath .. " -run " .. testName
          sys.CopyToSystemClipboard(cmd)
        end,
        ["OpenRecentFilesInAllPlaces"] = "lua require('telescope').extensions.recent_files.pick({only_cwd = false})",
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
