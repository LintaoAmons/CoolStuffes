return {
	{
		"LintaoAmons/bookmarks.nvim",
		event = "VeryLazy",
		-- dir = "/Volumes/t7ex/Documents/oatnil/beta/bookmarks.nvim",
		-- branch = "dev",
		config = function()
			require("bookmarks").setup({
				json_db_path = vim.fs.normalize(vim.fn.stdpath("data") .. "/bookmarks.db.json"),
				signs = {
					mark = {
						icon = "󰃁",
						color = "red",
					},
				},
			})
		end,
	},
}
