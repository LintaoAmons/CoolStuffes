local ls = require("luasnip")
local s = ls.s -- -> snippet
local i = ls.i -- -> insert mode
local t = ls.t -- -> text node


local snippets, autosnippets = {}, {}

local myFirstSnippet = s("chatNew", {
  t("[Lintao]"),
})

table.insert(snippets, myFirstSnippet)

return snippets, autosnippets
