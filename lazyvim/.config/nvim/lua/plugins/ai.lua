return {
  {
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
      require("gp").setup({
        openai_api_key = os.getenv("OPENAI_API_KEY"),
      })
    end,
  },
}
