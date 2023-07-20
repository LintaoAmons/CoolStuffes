return {
  "folke/flash.nvim",
  event = "VeryLazy",
  tag = "v1.1.0",
  ---@type Flash.Config
  opts = {},
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        -- default options: exact mode, multi window, all directions, with a backdrop
        require("flash").jump()
      end,
    },
    {
      "S",
      mode = { "n" },
      function()
        require("flash").treesitter()
      end,
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
  },
}
