return {
  {
    "rbong/vim-flog",
    event = "VeryLazy",
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
}
