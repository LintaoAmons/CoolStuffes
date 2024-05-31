return {
	"stevearc/aerial.nvim",
	event = "VeryLazy",
	config = function()
		require("aerial").setup()
	end,
}
