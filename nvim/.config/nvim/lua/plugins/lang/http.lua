-- use as example to show how to create a language autocmd group
local name = "langHttp"
vim.api.nvim_create_augroup(name, { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = name,
	pattern = {
		"*.http",
	},
	callback = function()
		vim.keymap.set('n', "<M-r>", "<Cmd>Rest run<CR>", {
			noremap = true,
			silent = true,
			nowait = true,
			buffer = vim.api.nvim_get_current_buf(),
		})
	end,
})

return {
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
		end,
	},
}
