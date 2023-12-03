return {
  -- {
  -- remove the color it is using
  --   "vidocqh/data-viewer.nvim",
  --   opts = {},
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "kkharji/sqlite.lua", -- Optional, sqlite support
  --   },
  -- },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = "tpope/vim-dadbod",
    event = "VeryLazy",
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-completion",
        event = "VeryLazy",
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            desc = "dadbod completion",
            group = vim.api.nvim_create_augroup("dadbod_cmp", { clear = true }),
            pattern = { "sql", "mysql", "plsql" },
            callback = function()
              require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
            end,
          })
        end,
      },
    },
  },
}
