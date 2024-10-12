return {
  "ggandor/leap.nvim",
  config = function()
    -- Disable auto-jumping to the first match
    require("leap").opts.safe_labels = {}

    -- The below settings make Leap's highlighting closer to what you've been
    -- used to in Lightspeed.

    vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
    vim.api.nvim_set_hl(0, "LeapMatch", {
      -- For light themes, set to 'black' or similar.
      fg = "white",
      bold = true,
      nocombine = true,
    })
    -- Deprecated option. Try it without this setting first, you might find
    -- you don't even miss it.
    require("leap").opts.highlight_unlabeled_phase_one_targets = true

    vim.keymap.set("n", "s", function()
      require("leap").leap({
        target_windows = require("leap.user").get_focusable_windows(),
      })
    end)
  end,
}
