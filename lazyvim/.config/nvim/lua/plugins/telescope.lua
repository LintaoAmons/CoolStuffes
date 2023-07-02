return {
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
}
