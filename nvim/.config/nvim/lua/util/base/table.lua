local M        = {}

M.table_length = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function M.findIndex(tbl, element)
  for i = 1, #tbl do
    if tbl[i] == element then
      return i
    end
  end
  return nil
end

---@param element any
---@param table any
---@return boolean
function M.isElementInTable(element, table)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

---comment
---@param array1 table
---@param array2 table
---@return table
function M.getDifferenceSet(array1, array2)
    local differenceSet = {}

    for _, value in ipairs(array1) do
        if not M.isElementInTable(value, array2) then
            table.insert(differenceSet, value)
        end
    end

    return differenceSet
end

return M

