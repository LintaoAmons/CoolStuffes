vim.keymap.set({ "n", "v" }, "<C-f>", function()
  require("grug-far").grug_far()
end)

return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      wrap = false,
      keymaps = {
        replace = { n = "<localleader>r" },
        qflist = { n = "<localleader>q" },
        syncLocations = { n = "<localleader>s" },
        syncLine = { n = "<localleader>l" },
        close = { n = "<localleader>c" },
        historyOpen = { n = "<localleader>t" },
        historyAdd = { n = "<localleader>a" },
        refresh = { n = "<localleader>f" },
        openLocation = { n = "<localleader>o" },
        openNextLocation = { n = "<down>" },
        openPrevLocation = { n = "<up>" },
        gotoLocation = { n = "<enter>" },
        pickHistoryEntry = { n = "<enter>" },
        abort = { n = "<localleader>b" },
        help = { n = "g?" },
        toggleShowCommand = { n = "<localleader>p" },
        swapEngine = { n = "<localleader>e" },
        previewLocation = { n = "<localleader>i" },
        swapReplacementInterpreter = { n = "<localleader>x" },
      },
    })
  end,
}
