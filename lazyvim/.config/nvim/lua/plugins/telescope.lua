return {
  {
    "nvim-telescope/telescope.nvim",
    -- HACK: opts will be merged with the parent spec
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
      },
    },
  },
  {
    "smartpde/telescope-recent-files",
    config = function()
      require("telescope").setup({
        extensions = {
          recent_files = {
            only_cwd = true,
          },
        },
      })
      require("telescope").load_extension("recent_files")
    end,
  },
}
