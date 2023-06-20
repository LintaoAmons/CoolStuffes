--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]
lvim.plugins = require("lintao.plugins")

lvim.colorscheme = "material"
vim.g.material_style = "darker"

lvim.leader = "space"
require("lintao.keymappings")

require("lintao.cmp")
require("lintao.telescope")
require("lintao.copilot")
require("lintao.ufo")
require("lintao.fzf")
require("lintao.null-ls")
require("lintao.lsp")
require("lintao.treesitter")

require("telescope").load_extension('harpoon')

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.cmdheight = 0

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = false,
  pattern = "*.lua",
  timeout = 1000,
}

lvim.builtin.project.show_hidden = true

-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- Change theme settings
-- lvim.colorscheme = "lunar"

lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false


-- HACK: Full screen TOGGLETERM
local function get_buf_size()
  local cbuf = vim.api.nvim_get_current_buf()
  local bufinfo = vim.tbl_filter(function(buf)
    return buf.bufnr == cbuf
  end, vim.fn.getwininfo(vim.api.nvim_get_current_win()))[1]
  if bufinfo == nil then
    return { width = -1, height = -1 }
  end
  return { width = bufinfo.width, height = bufinfo.height }
end

local buf_size = get_buf_size()
lvim.builtin.terminal.float_opts.width = buf_size.width
lvim.builtin.terminal.float_opts.height = buf_size.height

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
--

-- HACK 🔥auto-save
local function save()
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_buf_call(buf, function()
    vim.cmd("silent! write")
  end)
end

vim.api.nvim_create_augroup("AutoSave", {
  clear = true,
})

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  callback = function()
    save()
  end,
  pattern = "*",
  group = "AutoSave",
})
