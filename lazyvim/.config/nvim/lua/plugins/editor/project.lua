return {
	{
		"LintaoAmons/cd-project.nvim",
    -- dir = "/Volumes/t7ex/Documents/oatnil/release/cd-project.nvim",
		config = function()
			require("cd-project").setup({
				projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("data") .. "/cd-project.nvim.json"),
				projects_picker = "telescope", -- optional, you can switch to `telescope`
        auto_register_project = true,
				hooks = {
					{
						callback = function(_)
							vim.cmd("Telescope fd")
						end,
					},
				},
			})
		end,
	},
}
