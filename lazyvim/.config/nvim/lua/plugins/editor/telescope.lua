return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	opts = {
		pickers = {
			find_files = {
				theme = "dropdown",
			},
			live_grep = {
				theme = "ivy",
			},
		},
	},
}
