require 'fzf-lua'.setup({
  commands = {
    actions = { ["default"] = require 'fzf-lua'.actions.ex_run_cr },
    sort_lastused = true,
  },
})
