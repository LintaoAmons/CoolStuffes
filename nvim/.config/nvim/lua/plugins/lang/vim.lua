return {
  -- Syntax hightlight
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.g.config_utils.opts_ensure_installed(opts, {
        "vim",
        "vimdoc",
      })
    end,
  },
}
