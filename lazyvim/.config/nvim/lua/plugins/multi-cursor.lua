return { -- Multi Cursor
  -- https://github.com/chrisgrieser/.config/blob/106d4eb2f039f1b9506fd5cfeed7e7d09f832e87/nvim/lua/plugins/bulk-processing.lua#L3C12-L3C12
  "mg979/vim-visual-multi",
  -- keys = { { "<M-b>", mode = { "n", "x" }, desc = "󰆿 Multi-Cursor" } },
  event = "VeryLazy",
  init = function()
    -- Multi-Cursor https://github.com/mg979/vim-visual-multi/blob/master/doc/vm-mappings.txt
    -- vim.g.VM_leader = "\\"
    vim.g.VM_theme = "purplegray"

    -- https://github.com/mg979/vim-visual-multi/wiki/Mappings#full-mappings-list
    vim.g.VM_maps = {
      -- permanent mappings
      ["Find Under"] = "<M-b>",
      ["Find Subword Under"] = "<M-b>", -- firstly select some text, then <M-b>
      ["Start Regex Search"] = "<C-q>/",

      ["Select Cursor Down"] = "<C-j>", -- switch upper and lower window with <C-w>jk
      ["Select Cursor Up"] = "<C-k>",

      ["Visual All"] = "<C-q>j", --  selected some text in visual mode then press <C-q>j to select all

      -- buffer mappings
      ["Switch Mode"] = "<Tab>",
      ["Remove Region"] = "Q",
      ["Goto Next"] = "}",
      ["Goto Prev"] = "{",

      ["Duplicate"] = "<C-q>d",

      ["Tools Menu"] = "<C-q>t",
      ["Case Conversion Menu"] = "C",
      ["Align"] = "<C-q>a",
    }

    vim.g.VM_set_statusline = 0 -- already set via lualine component
  end,
}
