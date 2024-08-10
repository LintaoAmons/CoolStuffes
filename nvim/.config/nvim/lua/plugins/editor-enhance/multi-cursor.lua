return { -- Multi Cursor
  -- https://github.com/chrisgrieser/.config/blob/106d4eb2f039f1b9506fd5cfeed7e7d09f832e87/nvim/lua/plugins/bulk-processing.lua#L3C12-L3C12
  "mg979/vim-visual-multi",
  event = "VeryLazy",
  init = function()
    -- Multi-Cursor https://github.com/mg979/vim-visual-multi/blob/master/doc/vm-mappings.txt
    -- vim.g.VM_leader = "\\"
    vim.g.VM_theme = "purplegray"

    vim.g.VM_maps = {
      -- TODO: fix mappings <C-q> already been used to check project
      -- permanent mappings
      ["Find Under"] = "<M-b>",
      ["Find Subword Under"] = "<M-b>", -- select some text firstly , then <M-b>

      -- ["Select Cursor Down"] = "<C-S-j>", -- switch upper and lower window with <C-w>jk
      -- ["Select Cursor Up"] = "<C-S-k>",
      ["Select Cursor Down"] = "<C-S-j>",

      -- ["Start Regex Search"] = "<C-q>/",
      ["Visual All"] = "\\A", --  1. selected some text in visual mode 2. press <C-q>j to select all

      -- buffer mappings
      ["Switch Mode"] = "v",
      ["Skip Region"] = "q",
      ["Remove Region"] = "Q",
      ["Goto Next"] = "}",
      ["Goto Prev"] = "{",

      -- ["Duplicate"] = "<C-q>d",

      ["Tools Menu"] = "\\t",
      ["Case Conversion Menu"] = "C",
      ["Align"] = "\\a",
    }

    -- https://github.com/mg979/vim-visual-multi/wiki/Mappings#full-mappings-list
    vim.g.VM_set_statusline = 0 -- already set via lualine component
  end,
}
