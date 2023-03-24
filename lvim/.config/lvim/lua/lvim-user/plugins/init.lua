local plugins = {
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        execution_message = nil
      })
    end,
  },
  { "christoomey/vim-tmux-navigator" },
  { "tpope/vim-fugitive" },
  { "gennaro-tedesco/nvim-jqx" },
  { "aduros/ai.vim" },
  { "stevearc/oil.nvim" },
  { "ray-x/guihua.lua" },
  { "f-person/git-blame.nvim" },
  { "LintaoAmons/scratch.nvim" },
  -- { "/Users/lintao/Documents/projects/scratch.nvim"},
  { "ggandor/leap.nvim" },
  { "stevearc/aerial.nvim" },
  {
    "kylechui/nvim-surround",
    config = function() require("nvim-surround").setup {} end,
  },
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },

  { "stevearc/dressing.nvim" },
  { "djoshea/vim-autoread" },
  { "glepnir/lspsaga.nvim" },
  {
    "michaelb/sniprun",
    run = "bash ./install.sh",
    config = function()
      require("sniprun").setup {
        live_mode_toggle = "enable",
        display = {
          "Terminal",
        },
      }
    end,
  },
}

local colorschemes = {
  { "luisiacc/gruvbox-baby" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "catppuccin/nvim" },
  { "EdenEast/nightfox.nvim" },
  { "marko-cerovac/material.nvim" },
}

for _, value in ipairs(colorschemes) do
  table.insert(plugins, value)
end

return plugins
