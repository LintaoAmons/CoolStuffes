-- local explorer        = require('ide.components.explorer')
-- local outline   = require('ide.components.outline')
-- local callhierarchy   = require('ide.components.callhierarchy')
local timeline  = require('ide.components.timeline')
-- local terminal  = require('ide.components.terminal')
-- local terminalbrowser = require('ide.components.terminal.terminalbrowser')
local changes   = require('ide.components.changes')
local commits   = require('ide.components.commits')
local branches  = require('ide.components.branches')
local bookmarks = require('ide.components.bookmarks')

require('ide').setup({
  -- the global icon set to use.
  -- values: "nerd", "codicon", "default"
  icon_set = "default",
  -- place Component config overrides here.
  -- they key to this table must be the Component's unique name and the value
  -- is a table which overrides any default config values.
  components = {},
  -- default panel groups to display on left and right.
  panels = {
    -- left = "explorer",
    left = nil,
    right = "bookmarks"
  },
  -- panels defined by groups of components, user is free to redefine these
  -- or add more.
  panel_groups = {
    -- explorer = { outline.Name },
    -- terminal = { terminal.Name },
    git = { changes.Name, commits.Name, timeline.Name, branches.Name },
    bookmarks = { bookmarks.Name }
  }
})
