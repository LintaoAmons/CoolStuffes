---
local formatFunc = function(args)
  local range = nil
  if args and args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end
vim.keymap.set("n", "<leader>fm", formatFunc)
vim.api.nvim_create_user_command("Format", formatFunc, { range = true })

---@alias ConformCtx {buf: number, filename: string, dirname: string}
local M = {}

local prettier_supported = {
  "css",
  "graphql",
  "handlebars",
  "html",
  "javascript",
  "javascriptreact",
  "json",
  "jsonc",
  "less",
  "markdown",
  "markdown.mdx",
  "scss",
  "typescript",
  "typescriptreact",
  "vue",
  "yaml",
}

--- Checks if a Prettier config file exists for the given context
---@param ctx ConformCtx
function M.has_config(ctx)
  vim.fn.system({ "prettier", "--find-config-path", ctx.filename })
  return vim.v.shell_error == 0
end

return {
  "stevearc/conform.nvim",

  opts = function()
    local opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        xml = { "xmlformat" },

        -- terraform
        tf = { "terraform_fmt" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
    }
    require("conform").setup()

    for _, ft in ipairs(prettier_supported) do
      opts.formatters_by_ft[ft] = { "prettier" }
    end
    require("conform").setup(opts)
  end,
}
