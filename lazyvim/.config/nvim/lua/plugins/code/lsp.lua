return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			-- disable a keymap
			keys[#keys + 1] = { "gd", false } -- in favor of lspsaga
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = false,
					enable_in_insert = false,
					-- sign = true,
					-- sign_priority = 40,
					-- virtual_text = false,
				},
				outline = {
					auto_preview = false,
				},
				definition = {
					keys = {
						edit = "o",
					},
				},
			})
		end,
		event = "LspAttach",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
}
