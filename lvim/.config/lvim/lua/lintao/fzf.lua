require 'fzf-lua'.setup({
  -- TODO commands layout
  commands = {
    actions = { ["default"] = require 'fzf-lua'.actions.ex_run_cr },
    sort_lastused = true,
  },
})
