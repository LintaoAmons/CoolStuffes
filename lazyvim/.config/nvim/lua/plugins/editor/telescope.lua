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
		defaults = {
			mappings = {
				i = {
					["jk"] = require("telescope.actions").close,
				},
				n = {
					["jk"] = require("telescope.actions").close,
				},
			},
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
		},
	},
}
