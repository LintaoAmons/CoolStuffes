return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      disable_keymaps = true,
      log_level = "error",
    })

    local completion_preview = require("supermaven-nvim.completion_preview")
    vim.keymap.set(
      "i",
      "<c-a>",
      completion_preview.on_accept_suggestion,
      { noremap = true, silent = true }
    )
    vim.keymap.set(
      "i",
      "<c-j>",
      completion_preview.on_accept_suggestion_word,
      { noremap = true, silent = true }
    )
  end,
}
