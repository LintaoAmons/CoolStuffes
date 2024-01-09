local ls = require("luasnip")
local s = ls.s -- -> snippet
local i = ls.i
local t = ls.t -- -> text node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

return {
  s("chatNew", {
    t("Hi! That is my first snippet in Luasnip"),
  }),
  s(
    "testfactory",
    fmt(
      [[
  private data class {}TestCase(
    val testName: String,
  )

  @TestFactory
  fun `{} Test`() = listOf(
    {}TestCase(
      testName = ""
    ),
  ).map { testcase ->
    DynamicTest.dynamicTest("$testcase") {
      // given

      // when

      // then
    }
  }
  ]],
      { i(1), rep(1), rep(1) }
    )
  ),
}
