return {
  "b0o/incline.nvim",
  event = "UIEnter",
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    require("incline").setup({
      highlight = {
        groups = {
          InclineNormal = { guibg = "#44406e" },
          InclineNormalNC = { guifg = "#3D4143", guibg = "#202325" },
        },
      },

      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":.")
        if filename == "" then
          filename = "[No Name]"
        end
        local modified = vim.bo[props.buf].modified
        return {
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
        }
      end,
    })
  end,
}
