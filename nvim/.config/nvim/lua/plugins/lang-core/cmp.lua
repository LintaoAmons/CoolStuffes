return {
  -- use CmpStatus to check the running cmp sources
  -- auto completion
  {
    "onsails/lspkind-nvim",
    event = "InsertEnter",
    config = function()
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            -- can also be a function to dynamically calculate max width such as
            -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            show_labelDetails = true, -- show labelDetails in menu. Disabled by default
            symbol_map = { Supermaven = "" },

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          }),
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ["<S-CR>"] = cmp.mapping.confirm({
          --   behavior = cmp.ConfirmBehavior.Replace,
          --   select = true,
          -- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          -- ["<C-CR>"] = function(fallback)
          --   cmp.abort()
          --   fallback()
          -- end,
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "supermaven" },
        }, {
          { name = "buffer" },
        }),
        -- experimental = {
        --   ghost_text = {
        --     hl_group = "CmpGhostText",
        --   },
        -- },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      require("cmp").setup(opts)
    end,
  },

  {
    "hrsh7th/cmp-cmdline",
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = function()
      local cmp = require("cmp")
      return {
        {
          type = "/",
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = "buffer" },
          },
        },
        {
          type = ":",
          mapping = cmp.mapping.preset.cmdline({

            ["<Down>"] = {
              c = function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end,
            },
            ["<Up>"] = {
              c = function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end,
            },
            ["<Tab>"] = {
              c = function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end,
            },
          }),
          sources = cmp.config.sources({
            { name = "path" },
          }, {
            {
              name = "cmdline",
              option = {
                ignore_cmds = { "Man", "!" },
              },
            },
          }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      vim.tbl_map(function(val)
        cmp.setup.cmdline(val.type, val)
      end, opts)
    end,
  },
}
