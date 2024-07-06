return {
  "mfussenegger/nvim-lint",
  config = function()
    -- TODO: find a way to modulize the config
    require("lint").linters_by_ft = {
      markdown = { "vale" },

      tf = { "tfsec" },
      terraform = { "tfsec" },
      ["terraform-vars"] = { "tfsec" },
    }
  end,
}
