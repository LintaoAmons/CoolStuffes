--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
lvim.plugins = require("lintao.plugins")

lvim.colorscheme = "material"
vim.g.material_style = "darker"

require("lintao.keymappings")
require("lintao.cmp")
require("lintao.telescope")
require("lintao.copilot")
require("lintao.ufo")
require("lintao.fzf")
require("lintao.null-ls")
require("lintao.lsp")
require("lintao.treesitter")

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = false,
  pattern = "*.lua",
  timeout = 1000,
}

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- Additional Plugins <https://www.lunarvim.org/docs/configuration/plugins/user-plugins>

-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
--
