local function ReplacePattern(str, pattern, replacement)
  return string.gsub(str, pattern, replacement)
end

local function trim(input)
  return input:gsub("^%s*(.-)%s*$", "%1")
end

local function contains(str, char)
  return str:find(char, 1, true) ~= nil
end

local function EndsWithSuffix(str, suffix)
  local len = #suffix
  return str:sub(-len) == suffix
end

---@param i string
---@return string[]
local function split_into_lines(i)
  local lines = {}
  for line in i:gmatch("([^\n]*)\n?") do
    if line ~= "" then
      table.insert(lines, line)
    end
  end
  return lines
end

---@param stringList string[]
---@param delimiter string
---@return string
local function join(stringList, delimiter)
  local str = ""
  for i, s in ipairs(stringList) do
    str = str .. s
    if i ~= #stringList then
      str = str .. delimiter
    end
  end
  return str
end

local function splitCmdString(cmd)
  local t = {}
  local inQuotes = false
  local currentQuoteChar = nil
  local currentWord = ""

  for i = 1, #cmd do
    local c = cmd:sub(i, i)
    if c == " " and not inQuotes then
      if #currentWord > 0 then
        table.insert(t, currentWord)
        currentWord = ""
      end
    elseif c == "'" or c == '"' then
      if inQuotes and currentQuoteChar == c then
        inQuotes = false
        currentQuoteChar = nil
      elseif not inQuotes then
        inQuotes = true
        currentQuoteChar = c
      else
        currentWord = currentWord .. c
      end
    else
      currentWord = currentWord .. c
    end
  end
  if #currentWord > 0 then
    table.insert(t, currentWord)
  end
  return t
end

---split the string by delimiter
---@param inputStr string
---@param delimiter string
---@return string[]
local function split(inputStr, delimiter)
  local t = {}
  local pattern = "([^" .. delimiter .. "]+)"
  for str in string.gmatch(inputStr, pattern) do
    table.insert(t, str)
  end
  return t
end

local M = {
  replace_pattern = ReplacePattern,
  trim = trim,
  split = split,
  contains = contains,
  ends_with_suffix = EndsWithSuffix,
  split_into_lines = split_into_lines,
  join = join,
  split_cmd_string = splitCmdString,
}

return M
