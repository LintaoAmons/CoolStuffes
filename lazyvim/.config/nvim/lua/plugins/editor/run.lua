return {
	{
		"michaelb/sniprun",
		event = "VeryLazy",
		build = "bash ./install.sh",
		config = function()
			-- HACK: https://michaelb.github.io/sniprun/sources/README.html#usage
			require("sniprun").setup({
				live_mode_toggle = "enable",
				display = {
					"Classic", --# display results in the command-line  area
					"VirtualText", --# display ok results as virtual text (multiline is shortened)
					"Terminal",
				},
				display_options = {
					terminal_scrollback = vim.o.scrollback,
				},
				live_display = { "VirtualText", "Terminal" },
			})
		end,
	},
}
