vim.keymap.set({ "n", "v" }, "<C-q>", "<cmd>CdProject<cr>")

return {
  {
    -- "LintaoAmons/cd-project.nvim",
    dir = "/Volumes/t7ex/Documents/oatnil/release/cd-project.nvim",
    init = function()
      require("cd-project").setup({
        projects_config_filepath = vim.fn.stdpath("data") .. "/cd-project.nvim.json",
        project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
        projects_picker = "telescope", -- optional, you can switch to `telescope`
        auto_register_project = true,
        format_json = true,
        hooks = {
          {
            trigger_point = "BEFORE_CD",
            callback = function(_)
              vim.print("before cd project")
              require("bookmarks").api.mark({name = "before cd project"})
            end,
          },
          {
            callback = function(_)
              require("telescope").extensions.smart_open.smart_open({
                cwd_only = true,
                filename_first = false,
              })
            end,
          },
        },
      })
    end,
  },
}
