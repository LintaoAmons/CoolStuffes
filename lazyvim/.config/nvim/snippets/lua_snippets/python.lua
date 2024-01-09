local ls = require("luasnip")
local s = ls.s
local i = ls.i
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local t = ls.text_node

return {
  s(
    "readFileAsStringList",
    fmt(
      [[
  def read_text_file(file_path: str) -> str:
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()
            return content
    except FileNotFoundError:
        return "File not found. Please check the file path."


  def read_text_file_as_string_list(file_path: str) -> list[str]:
    return read_text_file(file_path).splitlines()
]],
      {}
    )
  ),
  s("callReadFileAsStringList", fmt('read_text_file_as_string_list("{}")', { i(1) })),
}
