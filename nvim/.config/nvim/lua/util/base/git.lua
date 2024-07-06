---
local function get_current_version()
  local result, _ = vim.fn.system("git rev-parse --short HEAD"):gsub("\n", "")
  return result
end

return {
  get_current_version = get_current_version,
}
