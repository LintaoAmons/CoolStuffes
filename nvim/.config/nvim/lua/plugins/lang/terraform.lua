-- lang-core.formatting.lua conform.nvim
-- lang-core.lint.lua nvim-lint.nvim
-- lang-core.tresitter nvim-treesitter

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        tf = { "terraform_fmt" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
    },
  },
}
