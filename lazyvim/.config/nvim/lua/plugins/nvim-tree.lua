-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
return {
  "nvim-tree/nvim-tree.lua",
  opts = {
    sync_root_with_cwd = true,
  },
}
