require("no-neck-pain").setup({
  enableOnVimEnter = false,
  enableOnTabEnter = false,
  width = 120,
  integrations = {
    -- By default, if NvimTree is open, we will close it and reopen it when enabling the plugin,
    -- this prevents having the side buffers wrongly positioned.
    -- @link https://github.com/nvim-tree/nvim-tree.lua
    NvimTree = {
      -- The position of the tree, either `left` or `right`.
      position = "left",
      -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
      reopen = true,
    },
    -- @link https://github.com/mbbill/undotree
    undotree = {
      -- The position of the tree, either `left` or `right`.
      position = "left",
    },
  },
})
