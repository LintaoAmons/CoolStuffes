-- REF: https://github.com/AstroNvim/astrocommunity/blob/d64d788e163f6d759e8a1adf4281dd5dd2841a78/lua/astrocommunity/terminal-integration/toggleterm-manager-nvim/init.lua
-- if you only want these mappings for toggle term use term://*toggleterm#* instead
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-t>", [[<C-\><C-n><C-t>]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

return {
	"ryanmsnyder/toggleterm-manager.nvim",
	dependencies = {
		"akinsho/nvim-toggleterm.lua",
		"nvim-telescope/telescope.nvim",
		"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
	},
	config = function()
		local toggleterm_manager = require("toggleterm-manager")
		local actions = toggleterm_manager.actions

		toggleterm_manager.setup({
			mappings = {
				i = {
					["<CR>"] = { action = actions.open_term, exit_on_action = true },
					["<C-d>"] = { action = actions.delete_term, exit_on_action = false },
				},
				n = {
					["<CR>"] = { action = actions.create_and_name_term, exit_on_action = true },
					["x"] = { action = actions.delete_term, exit_on_action = false },
				},
			},
		})
	end,
}
