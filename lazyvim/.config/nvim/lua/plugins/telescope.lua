return {
  {
    "nvim-telescope/telescope-frecency.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").load_extension("frecency")
    end,
  },
  {
    "princejoogie/dir-telescope.nvim",
    -- telescope.nvim is a required dependency
    event = "VeryLazy",
    requires = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("dir-telescope").setup({
        -- these are the default options set
        hidden = true,
        no_ignore = false,
        show_preview = true,
        find_command = function()
          return { "fd", "--type", "d", "--color", "never", "-E", ".git" }
        end,
      })
      require("telescope").load_extension("dir")
    end,
  },
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
          },
        },
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add telescope-fzf-native
  {
    "telescope.nvim",
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
      { "<leader>ss", false },
    },
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },

  {
    "smartpde/telescope-recent-files",
    event = "VeryLazy",
    config = function()
      require("telescope").setup({
        extensions = {
          recent_files = {
            only_cwd = true,
          },
        },
      })
      require("telescope").load_extension("recent_files")
    end,
  },
}
