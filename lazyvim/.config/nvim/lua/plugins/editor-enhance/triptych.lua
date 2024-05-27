return 	{
		"simonmclean/triptych.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"nvim-tree/nvim-web-devicons", -- optional
		},
		opts = {
			mappings = {
				-- Everything below is buffer-local, meaning it will only apply to Triptych windows
				show_help = "g?",
				jump_to_cwd = ".", -- Pressing again will toggle back
				nav_left = "h",
				nav_right = { "l", "<CR>" }, -- If target is a file, opens the file in-place
				open_hsplit = { "-" },
				open_vsplit = { "s" },
				open_tab = { "<C-t>" },
				cd = "<leader>cd",
				delete = "d",
				add = "a",
				copy = "c",
				rename = "r",
				cut = "x",
				paste = "p",
				quit = "q",
				toggle_hidden = "<leader>.",
			},
			extension_mappings = {
				["<c-f>"] = {
					mode = "n",
					fn = function(target)
						require("telescope.builtin").live_grep({
							search_dirs = { target.path },
						})
					end,
				},
			},
		},
	}

