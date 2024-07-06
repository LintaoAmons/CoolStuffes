local toggle_debug_ui = function()
  require("dapui").toggle()
end
vim.keymap.set("n", "<M-5>", toggle_debug_ui)
vim.api.nvim_create_user_command("ToggleDebugUI", toggle_debug_ui, {})

local eval = function()
  require("dapui").eval()
end
vim.keymap.set("n", "<M-5>", eval)
vim.api.nvim_create_user_command("DebugEval", eval, {})

local start_or_continue = function()
  require("dap").continue()
end
vim.keymap.set("n", "<F5>", start_or_continue)
vim.api.nvim_create_user_command("DebugStartOrContinue", start_or_continue, {})

local step_over = function()
  require("dap").step_over()
end
vim.keymap.set("n", "<F8>", step_over)
vim.api.nvim_create_user_command("DebugStepOver", step_over, {})

local step_into = function()
  require("dap").step_into()
end
vim.keymap.set("n", "<F7>", step_into)
vim.api.nvim_create_user_command("DebugStepInto", step_into, {})

local terminate = function()
  require("dap").terminate()
end
vim.keymap.set("n", "<M-F2>", terminate)
vim.api.nvim_create_user_command("DebugStop", terminate, {})

local toggle_break_point = function()
  require("dap").toggle_breakpoint()
end
vim.keymap.set("n", "<F9>", toggle_break_point)
vim.api.nvim_create_user_command("DebugToggleBreakpoint", toggle_break_point, {})

return {
  -- fancy UI for the debugger
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function(_, opts)
      -- setup dap config by VsCode launch.json file
      -- require("dap.ext.vscode").load_launchjs()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({})
      end
    end,
  },

  {
    "mfussenegger/nvim-dap",

    dependencies = {

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },
    },

    config = function()
      vim.fn.sign_define("DapBreakpoint", {
        text = "🔴",
        linehl = "DapBreakpoint",
      })

      vim.fn.sign_define("DapStopped", {
        text = "▶️",
        linehl = "DapBreakpointStopped",
      })
      vim.fn.sign_define("DapBreakpointCondition", {
        text = " ",
      })
      vim.fn.sign_define("DapLogPoint", {
        text = ".>",
      })

      vim.api.nvim_set_hl(0, "DapBreakpoint", { bg = "#552B24" })
      vim.api.nvim_set_hl(0, "DapBreakpointStopped", { bg = "#244C55" })
    end,
  },
}
