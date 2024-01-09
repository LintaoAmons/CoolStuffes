local ls = require("luasnip")
local s = ls.s -- -> snippet
local i = ls.i -- -> insert mode
local t = ls.t -- -> text node

return {
  s("lin", {
    t("[Lintao]"),
  }),
}
