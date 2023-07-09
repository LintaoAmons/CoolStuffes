return { -- Multi Cursor
  -- https://github.com/chrisgrieser/.config/blob/106d4eb2f039f1b9506fd5cfeed7e7d09f832e87/nvim/lua/plugins/bulk-processing.lua#L3C12-L3C12
  "mg979/vim-visual-multi",
  keys = { { "<M-b>", mode = { "n", "x" }, desc = "󰆿 Multi-Cursor" } },
  init = function()
    -- Multi-Cursor https://github.com/mg979/vim-visual-multi/blob/master/doc/vm-mappings.txt
    vim.g.VM_maps = {
      ["Find Under"] = "<M-b>", -- select word under cursor & enter visual-multi (normal) / add next occurrence (visual-multi)
      ["Visual Add"] = "<M-b>", -- enter visual-multi (visual)
      ["Skip Region"] = "<M-C-b>", -- skip current selection (visual-multi)
      ["Select Cursor Down"] = "<M-C-l>",
      ["Select Cursor Up"] = "<M-C-h>",
    }
    vim.g.VM_set_statusline = 0 -- already set via lualine component
  end,
}
