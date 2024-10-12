vim.keymap.set({ "n", "v", "i" }, "<M-C-n>", "<cmd>Scratch<cr>")
vim.keymap.set({ "n", "v", "i" }, "<M-C-o>", "<cmd>ScratchOpen<cr>")

return {
  "LintaoAmons/scratch.nvim",
  -- branch = "dev",
  -- dir = "/Volumes/t7ex/Documents/oatnil/release/scratch.nvim",
  config = function()
    require("scratch").setup({
      scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- where your scratch files will be put
      filetypes = { "lua", "js", "sh", "ts", "md", "txt", "http", "html", "puml", "py" }, -- you can simply put filetype here
      hooks = {
        {
          callback = function()
            vim.print("hello")
            vim.api.nvim_buf_set_lines(0, 0, -1, false, { "hello", "world" })
          end,
        },
      },
      filetype_details = { -- or, you can have more control here
        json = {}, -- empty table is fine
        ["project-name.md"] = {
          subdir = "project-name", -- group scratch files under specific sub folder
        },
        ["yaml"] = {},
        go = {
          requireDir = true, -- true if each scratch file requires a new directory
          filename = "main", -- the filename of the scratch file in the new directory
          content = { "package main", "", "func main() {", "  ", "}" },
          cursor = {
            location = { 4, 2 },
            insert_mode = true,
          },
        },
      },
      window_cmd = "edit", -- 'vsplit' | 'split' | 'edit' | 'tabedit' | 'rightbelow vsplit'
      file_picker = "fzflua",
      localKeys = {
        {
          filenameContains = { "sh" },
          LocalKeys = {
            {
              cmd = "<CMD>RunShellCurrentLine<CR>",
              key = "<C-r>",
              modes = { "n", "i", "v" },
            },
          },
        },
      },
    })
  end,
  event = "VeryLazy",
}
