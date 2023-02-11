lvim.log.level = "off"
lvim.format_on_save.enabled = false

lvim.colorscheme = "material"
vim.g.material_style = "darker"

lvim.lsp.automatic_servers_installation = true
lvim.builtin.cmp.confirm_opts.select = true

require("lvim-user.options")
require("lvim-user.my-mappings.mappings")

lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "sqls"
end, lvim.lsp.automatic_configuration.skipped_servers)

lvim.plugins = require("lvim-user.plugins")
require("lvim-user.plugins.treesitter")
require("lvim-user.plugins.codeium")
require("lvim-user.plugins.nvimtree")
require("lvim-user.plugins.no-neck-pain")
require("lvim-user.polish")

-- You probably also want to set a keymap to toggle aerial
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black" },
  {
    command = "prettier",
    args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  -- { command = "flake8" },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
  { name = 'jsonlint' },
  {
    command = "codespell",
    filetypes = { "javascript", "python" },
  },
}


-- local code_actions = require "lvim.lsp.null-ls.code_actions"
-- code_actions.setup {
--   {
--     command = "proselint"
