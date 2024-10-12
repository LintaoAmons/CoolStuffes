opts = { noremap = true, silent = true }
vim.keymap.set({ "n", "v" }, "<Leader>ac", "<cmd>CodeCompanionChat<cr>", opts)
vim.keymap.set({ "n", "v" }, "<Leader>ak", "<cmd>CodeCompanionActions<cr>", opts)
vim.keymap.set({ "n", "v" }, "<Leader>aj", "<cmd>CodeCompanion<cr>", opts)

return {
  "olimorris/codecompanion.nvim",
  -- dir ="/Volumes/t7ex/Documents/Github/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            url = "your_url",
          })
        end,
      },
      strategies = {
        chat = {
          adapter = "anthropic",
        },
        inline = {
          adapter = "anthropic",
        },
        agent = {
          adapter = "anthropic",
        },
      },
      prompt_library = {
        ["Commit Message for Staged Files"] = {
          strategy = "chat",
          description = "staged file commit messages",
          opts = {
            index = 9,
            default_prompt = true,
            mapping = "<LocalLeader>gm",
            slash_cmd = "commit-stage",
            auto_submit = true,
          },
          prompts = {
            {
              role = "system",
              content = "You are an expert at following the Conventional Commit specification.",
            },
            {
              role = "user",
              contains_code = true,
              content = function()
                return "Given the git diff listed below, please generate a commit message and put it inside a commit command for me:\n\n"
                  .. "```\n"
                  .. vim.fn.system("git diff --staged")
                  .. "\n```"
              end,
            },
          },
        },
      },
      keymaps = {
        send = {
          modes = {
            n = { "<CR>", "<C-s>" },
            i = "<C-s>",
          },
          index = 1,
          callback = "keymaps.send",
          description = "Send",
        },
      },
    })
  end,
}
