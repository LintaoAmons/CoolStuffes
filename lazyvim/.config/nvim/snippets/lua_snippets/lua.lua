local ls = require("luasnip")
local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  ls.parser.parse_snippet("enable", "enabled = false"),
  s("local", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
}
