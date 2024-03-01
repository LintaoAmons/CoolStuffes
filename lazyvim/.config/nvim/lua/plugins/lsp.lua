return {
  {
    "jubnzv/virtual-types.nvim",
    event = "LspAttach",
  },
  -- {
  --   "VidocqH/lsp-lens.nvim",
  --   event = "LspAttach",
  --   config = function()
  --     require("lsp-lens").setup({})
  --   end,
  -- },
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      -- disable a keymap
      keys[#keys + 1] = { "gd", false }
      -- add a keymap
      -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        outline = {
          auto_preview = false,
        },
        ui = {
          enable = false,
        },
        definition = {
          keys = {
            edit = "o",
          },
        },
      })
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
}
