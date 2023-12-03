return {
  "gelguy/wilder.nvim",
  enabled = false,
  dependencies = { "romgrk/fzy-lua-native" },
  config = function()
    local wilder = require("wilder")
    wilder.setup({ modes = { ":", "/", "?" } })
    -- Disable Python remote plugin
    wilder.set_option("use_python_remote_plugin", 0)

    vim.cmd([[ " Default keys
      call wilder#setup({
        \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ 'accept_key': '<Down>',
      \ 'reject_key': '<Up>',
      \ })]])

    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
      ),
    })

    wilder.set_option(
      "renderer",
      wilder.renderer_mux({
        [":"] = wilder.popupmenu_renderer({
          highlighter = wilder.lua_fzy_highlighter(),
          left = {
            " ",
            wilder.popupmenu_devicons(),
          },
          right = {
            " ",
            wilder.popupmenu_scrollbar(),
          },
        }),
        ["/"] = wilder.wildmenu_renderer({
          highlighter = wilder.lua_fzy_highlighter(),
        }),
      })
    )
  end,
}
