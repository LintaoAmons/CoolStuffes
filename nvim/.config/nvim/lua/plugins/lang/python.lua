return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft["python"] = { "ruff_format" }
    end,
  },
}
