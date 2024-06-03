return {
	"lewis6991/satellite.nvim",
	cond = function()
		return vim.fn.has("nvim-0.10") == 1
	end,
	opts = {
		winblend = 0,
	},
}
