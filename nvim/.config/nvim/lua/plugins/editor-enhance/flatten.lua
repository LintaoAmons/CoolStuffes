return {

  -- Open files and command output from wezterm, kitty, and neovim terminals in your current neovim instance
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    opts = {
      window = {
        -- Options:
        -- current        -> open in current window (default)
        -- alternate      -> open in alternate window (recommended)
        -- tab            -> open in new tab
        -- split          -> open in split
        -- vsplit         -> open in vsplit
        -- smart          -> smart open (avoids special buffers)
        -- OpenHandler    -> allows you to handle file opening yourself (see Types)
        --
        open = "alternate",
        -- Options:
        -- vsplit         -> opens files in diff vsplits
        -- split          -> opens files in diff splits
        -- tab_vsplit     -> creates a new tabpage, and opens diff vsplits
        -- tab_split      -> creates a new tabpage, and opens diff splits
        -- OpenHandler    -> allows you to handle file opening yourself (see Types)
        diff = "tab_vsplit",
        -- Affects which file gets focused when opening multiple at once
        -- Options:
        -- "first"        -> open first file of new files (default)
        -- "last"         -> open last file of new files
        focus = "first",
      },
    },
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
}
