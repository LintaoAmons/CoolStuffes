return {
  { "towolf/vim-helm", ft = "helm" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.g.config_utils.opts_ensure_installed(opts, { "helm" })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        helm_ls = {},
      },
      setup = {
        yamlls = function()
          vim.api.nvim_create_autocmd("LspAttach", {
            pattern = "*.helm",
            callback = function(args)
              local buffer = args.buf
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "yamlls" then
                if vim.bo[buffer].filetype == "helm" then
                  vim.schedule(function()
                    vim.cmd("LspStop ++force yamlls")
                  end)
                end
              end
            end,
          })
        end,
      },
    },
  },
}
