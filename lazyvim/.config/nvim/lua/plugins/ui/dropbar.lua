return {
	"Bekaboo/dropbar.nvim",
	cond = function()
		return vim.fn.has("nvim-0.10") == 1
	end,
}
