return {
	"mfussenegger/nvim-dap",

	dependencies = {

		-- fancy UI for the debugger
		{
			"rcarriga/nvim-dap-ui",
			keys = {
				{
					"<leader>du",
					function()
						require("dapui").toggle({})
					end,
					desc = "Dap UI",
				},
				{
					"<leader>de",
					function()
						require("dapui").eval()
					end,
					desc = "Eval",
					mode = { "n", "v" },
				},
			},
			opts = {},
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
}
