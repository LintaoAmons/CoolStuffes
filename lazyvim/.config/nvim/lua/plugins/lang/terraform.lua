vim.api.nvim_create_augroup("langTerraform", { clear = true })

-- fix tfvars (https://www.reddit.com/r/neovim/comments/125gctj/e5248_invalid_character_in_group_name_with/)
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "langTerraform",
	pattern = {
		"*.tf",
		"*.tfvars",
	},
	command = "set filetype=terraform",
})

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
				vim.list_extend(opts.ensure_installed, { "terraform" })
			end
		end,
	},

	-- mason lsp,debugger install
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "terraform-ls")
		end,
	},
}
