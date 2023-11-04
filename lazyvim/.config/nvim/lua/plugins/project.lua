return {
  {
    "natecraddock/workspaces.nvim",
    config = function(_, _)
      require("telescope").load_extension("workspaces")
      require("workspaces").setup({
        hooks = {
          open = { "Telescope find_files" },
        },
      })
    end,
  },
  -- {
  --   "aaditeynair/conduct.nvim",
  --   dependencies = "nvim-lua/plenary.nvim",
  --   cmd = {
  --     "ConductNewProject",
  --     "ConductLoadProject",
  --     "ConductLoadLastProject",
  --     "ConductLoadProjectConfig",
  --     "ConductReloadProjectConfig",
  --     "ConductDeleteProject",
  --     "ConductRenameProject",
  --     "ConductProjectNewSession",
  --     "ConductProjectLoadSession",
  --     "ConductProjectDeleteSession",
  --     "ConductProjectRenameSession",
  --   },
  -- },
  -- {
  --   "rmagatti/auto-session",
  --   config = function()
  --     require("auto-session").setup({
  --       log_level = "error",
  --       auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  --     })
  --   end,
  -- },
  -- {
  --   "rmagatti/session-lens",
  --   dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
  --   config = function()
  --     require("session-lens").setup({ --[[your custom config--]]
  --     })
  --   end,
  -- },
}
