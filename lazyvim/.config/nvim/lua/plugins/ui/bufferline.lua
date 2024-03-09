return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },
    opts = {
        options = {
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
            indicator = {
                style = "none"
            },
            show_buffer_close_icons = false,
            separator_style = { "", "" }
        },
    },
    dependencies = {
        "echasnovski/mini.bufremove"
    }
}
