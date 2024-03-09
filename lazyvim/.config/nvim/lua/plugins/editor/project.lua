return {
  {
    "LintaoAmons/cd-project.nvim",
    config = function()
      require("cd-project").setup({
        projects_picker = "telescope", -- optional, you can switch to `telescope`
        hooks = {
          {
            callback = function(_)
              vim.cmd("Telescope fd")
            end,
          },
        },
      })
    end,
  },
}
