return {
	{
		"LintaoAmons/cd-project.nvim",
		init = function()
			require("cd-project").setup({
				projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("data") .. "/cd-project.nvim.json"),
				project_dir_pattern = { ".git", ".gitignore", "Cargo.toml", "package.json", "go.mod" },
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
