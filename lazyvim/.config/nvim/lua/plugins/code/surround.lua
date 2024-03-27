return {
	-- { "NStefan002/visual-surround.nvim", opts = {} },
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
}
