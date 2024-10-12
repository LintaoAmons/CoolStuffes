local smart_open_cmd = function()
  require("telescope").extensions.smart_open.smart_open({
    cwd_only = true,
    filename_first = false,
  })
end
vim.keymap.set("n", "<C-p>", smart_open_cmd, { silent = true })

local smart_open_all = function()
  require("telescope").extensions.smart_open.smart_open({
    cwd_only = false,
    filename_first = false,
  })
end
vim.keymap.set("n", "<leader>fp", smart_open_all)
vim.api.nvim_create_user_command("SmartOpenAll", smart_open_all, {})

return {
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function()
      require("telescope").load_extension("smart_open")
    end,
    dependencies = {
      "kkharji/sqlite.lua",
      -- Only required if using match_algorithm fzf
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
  },

  {
    "LintaoAmons/context-menu.nvim",
    opts = function()
      require("context-menu").setup({
        close_menu = { "q", "<ESC>", "<M-l>" },
        menu_items = {
          {
            order = 1,
            keymap = "o",
            cmd = "OpenFileInAllPlace",
            action = {
              type = "callback",
              callback = function(_)
                vim.cmd([[SmartOpenAll]])
              end,
            },
          },
        },
      })
    end,
  },
}
