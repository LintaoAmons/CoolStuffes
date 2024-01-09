local ls = require("luasnip")
local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local t = ls.text_node

return {
  s("logger", t("private val logger = LoggerFactory.getLogger(this::class.java)")),
  s(
    "testfactory",
    fmt(
      [[
    private data class {}TestCase(
      val testName: String,
    )

    @TestFactory
    fun `{} Tests`() = listOf(
      {}TestCase(
        testName = "{}"
      ),
    ).map {{ testcase ->
      DynamicTest.dynamicTest(testcase.testName) {{
        // given

        // when

        // then
      }}
    }}
    ]],
      { i(1, "Example"), rep(1), rep(1), i(2, "Test Name") }
    )
  ),
}
