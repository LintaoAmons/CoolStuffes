return {
  {
    "ziontee113/syntax-tree-surfer",
  },
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "hcl",
        "terraform",
        "tsx",
        "typescript",
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        incremental_selection = {
          -- thx: https://www.reddit.com/r/neovim/comments/16ugm8l/comment/k2l4n06/?utm_source=share&utm_medium=web2x&context=3
          enable = true,
          keymaps = {
            node_incremental = "v",
            node_decremental = "V",
          },
        },
      })
    end,
  },
}
