return {
	"LintaoAmons/scratch.nvim",
	opts = {
		scratch_file_dir = vim.fn.stdpath("cache") .. "/scratch.nvim", -- where your scratch files will be put
		filetypes = { "lua", "js", "sh", "ts" }, -- you can simply put filetype here
		filetype_details = { -- or, you can have more control here
			json = {}, -- empty table is fine
			["yaml"] = {},
			go = {
				requireDir = true, -- true if each scratch file requires a new directory
				filename = "main", -- the filename of the scratch file in the new directory
				content = { "package main", "", "func main() {", "  ", "}" },
				cursor = {
					location = { 4, 2 },
					insert_mode = true,
				},
			},
		},
		window_cmd = "edit", -- 'vsplit' | 'split' | 'edit' | 'tabedit' | 'rightbelow vsplit'
		use_telescope = true,
		localKeys = {
			{
				filenameContains = { "sh" },
				LocalKeys = {
					{
						cmd = "<CMD>RunShellCurrentLine<CR>",
						key = "<C-r>",
						modes = { "n", "i", "v" },
					},
				},
			},
		},
	},
	event = "VeryLazy",
}
