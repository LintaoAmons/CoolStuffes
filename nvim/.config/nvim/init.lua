require("config.options")
require("config.keymaps")

vim.g.config_utils = {
  opts_ensure_installed = function(opts, new_item)
    opts = opts or {}
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, new_item)
    else
      opts.ensure_installed = new_item
    end
  end,
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
require("lazy").setup({
  spec = { { import = "plugins" } },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = false, -- get a notification when changes are found
  },
})
