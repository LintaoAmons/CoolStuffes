return {
  "Bekaboo/dropbar.nvim",
  cond = function()
    return vim.fn.has("nvim-0.10") == 1
  end,
  opts = function()
    local utils = require("dropbar.utils")
    return {
      menu = {
        -- When on, preview the symbol under the cursor on CursorMoved
        preview = true,
        -- When on, automatically set the cursor to the closest previous/next
        -- clickable component in the direction of cursor movement on CursorMoved
        quick_navigation = true,
        entry = {
          padding = {
            left = 1,
            right = 1,
          },
        },
        -- Menu scrollbar options
        scrollbar = {
          enable = true,
          -- The background / gutter of the scrollbar
          -- When false, only the scrollbar thumb is shown.
          background = true,
        },
        ---@type table<string, string|function|table<string, string|function>>
        keymaps = {
          ["q"] = "<C-w>q",
          ["<Esc>"] = "<C-w>q",
          ["h"] = "<C-w>q",
          ["<CR>"] = function()
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, "l")
            end
          end,
          ["l"] = function()
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local cursor = vim.api.nvim_win_get_cursor(menu.win)
            local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
            if component then
              menu:click_on(component, nil, 1, "l")
            end
          end,
          ["<MouseMove>"] = function()
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            local mouse = vim.fn.getmousepos()
            utils.menu.update_hover_hl(mouse)
            if M.opts.menu.preview then
              utils.menu.update_preview(mouse)
            end
          end,
          ["i"] = function()
            local menu = utils.menu.get_current()
            if not menu then
              return
            end
            menu:fuzzy_find_open()
          end,
        },
      },
    }
  end,
}
