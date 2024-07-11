local run_nearest = function()
  require("neotest").run.run()
end
vim.api.nvim_create_user_command("TestRunNearest", run_nearest, {})

local run_file = function()
  require("neotest").run.run(vim.fn.expand("%"))
end
vim.api.nvim_create_user_command("TestRunFile", run_file, {})

local summary_toggle = function()
  require("neotest").summary.toggle()
end
vim.api.nvim_create_user_command("TestSummaryToggle", summary_toggle, {})

local function debug_nearest()
  require("neotest").run.run({ strategy = "dap" })
end
vim.api.nvim_create_user_command("TestDebugNearest", debug_nearest, {})

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)

      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "jest",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
        quickfix = {
          open = function()
            require("trouble").open({ mode = "quickfix", focus = false })
          end,
        },
      })
    end,
  },
}

-- keys = {
--   {"<leader>t", "", desc = "+test"},
--   { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File" },
--   { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files" },
--   { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest" },
--   { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last" },
--   { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary" },
--   { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output" },
--   { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel" },
--   { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop" },
--   { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch" },
-- },
-- {
--   "mfussenegger/nvim-dap",
--   optional = true,
--   -- stylua: ignore
--   keys = {
--     { "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Debug Nearest" },
--   },
-- },
