local function setup_keybinding_and_commands()
  local toggle_debug_ui = function()
    require("dapui").toggle()
  end
  vim.api.nvim_create_user_command("ToggleDebugUI", toggle_debug_ui, {})

  local eval = function()
    require("dapui").eval()
  end
  vim.keymap.set("n", "<M-5>", eval)
  vim.api.nvim_create_user_command("DebugEval", eval, {})

  local start_or_continue = function()
    if vim.fn.filereadable("./vscode/launch.json") then
      local dap_vscode = require("dap.ext.vscode")
      dap_vscode.load_launchjs(nil, {})
    end
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
end
setup_keybinding_and_commands()

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
        -- vim.g.is_debuging = true
      end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup({
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
        all_references = false, -- show virtual text on all all references of the variable (not only definitions)
        clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
        --- A callback that determines how a variable is displayed or whether it should be omitted
        --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
        --- @param buf number
        --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
        --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
        --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
        --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
        display_callback = function(variable, buf, stackframe, node, options)
          -- by default, strip out new line characters
          if options.virt_text_pos == "inline" then
            return " = " .. variable.value:gsub("%s+", " ")
          else
            return variable.name .. " = " .. variable.value:gsub("%s+", " ")
          end
        end,
        -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
        virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

        -- experimental features:
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
      })
    end,
  },

  {
    "mfussenegger/nvim-dap",

    dependencies = {

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
      -- stylua ignore
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", linehl = "DapBreakpoint" })
      vim.fn.sign_define("DapStopped", { text = "▶️", linehl = "DapBreakpointStopped" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " " })
      vim.fn.sign_define("DapLogPoint", { text = ".>" })
    end,
  },
}
