return {
	-- treesitter syntax hightlight
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "json", "jsonc" })
			end
		end,
	},

	-- format
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "jq" },
			},
		},
	},

	-- mason lsp,debugger install
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "js-debug-adapter")
		end,
	},
}
