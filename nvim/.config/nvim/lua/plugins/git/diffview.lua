return {
	{
		"rbong/vim-flog",
		event = "VeryLazy",
		cmd = { "Flog", "Flogsplit", "Floggit" },
		dependencies = {
			"tpope/vim-fugitive",
		},
	},

	{
		"FabijanZulj/blame.nvim",
		event = "VeryLazy",
	},

	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			local action = require("diffview.actions")
			require("diffview").setup({
				keymaps = {
					view = {
						["r"] = function()
							vim.cmd("GitResetHunk")
							vim.notify("Reset hunk")
							vim.cmd("DiffviewRefresh")
						end,
						["gf"] = function()
							local diffview_tab = vim.api.nvim_get_current_tabpage()
							action.goto_file_edit()
							vim.api.nvim_command("tabclose " .. diffview_tab)
						end,
					},
					file_history_panel = {
						{ "n", "fa", "g!=a", { remap = true } },
						{ "n", "ff", "g!--", { remap = true } },
					},
					file_panel = {
						-- stash staged changes
						["<M-k>s"] = function()
							vim.ui.input({ prompt = "Stash msg: " }, function(msg)
								local Job = require("plenary.job")
								local stderr = {}
								Job:new({
									command = "git",
									args = { "stash", "-m", msg },
									cwd = ".",
									on_stderr = function(_, data)
										table.insert(stderr, data)
									end,
								}):sync()
							end)
						end,

						["c"] = function()
							vim.ui.input({ prompt = "Commit msg: " }, function(msg)
								local Job = require("plenary.job")
								local stderr = {}
								Job:new({
									command = "git",
									args = { "commit", "-m", msg },
									cwd = ".",
									on_stderr = function(_, data)
										table.insert(stderr, data)
									end,
								}):sync()
							end)
						end,

						["p"] = function()
							local Job = require("plenary.job")
							local stderr = {}
							Job:new({
								command = "git",
								args = { "push" },
								cwd = ".",
								on_stdout = function(_, data)
									vim.print("Pushed to remote")
									vim.print(data)
								end,
								on_stderr = function(_, data)
									table.insert(stderr, data)
								end,
							}):sync()
						end,
					},
				},
				view = {
					default = {
						winbar_info = true,
					},
					file_history = {
						winbar_info = true,
					},
				},
			})
		end,
	},
}
