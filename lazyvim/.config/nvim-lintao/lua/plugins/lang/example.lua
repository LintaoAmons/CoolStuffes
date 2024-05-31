if true then
	return {}
end

-- use as example to show how to create a language autocmd group
vim.api.nvim_create_augroup("langTerraform", { clear = true })

-- use as example to show how to automatically set the filetype
-- fix tfvars (https://www.reddit.com/r/neovim/comments/125gctj/e5248_invalid_character_in_group_name_with/)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "langTerraform",
	pattern = {
		"*.tf",
		"*.tfvars",
	},
	command = "set filetype=terraform",
})

-- use as example to show how to automatically set the indentation of a specific filetype
-- Set indentation to 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "langTerraform",
	pattern = {
		"*.tf",
		"*.tfvars",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})

return {

	-- treesitter syntax hightlight
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "javascript", "typescript", "tsx", "jsdoc" })
			end
		end,
	},

  -- format
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "jq" },
			},
		},
	},

	-- mason lsp,debugger install
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "js-debug-adapter")
		end,
	},
}
