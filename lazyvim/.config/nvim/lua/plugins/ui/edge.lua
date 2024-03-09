return {
	"folke/edgy.nvim",
	opts = function(_, opts)
		opts.left = {
			{
				title = "Neo-Tree",
				ft = "neo-tree",
				filter = function(buf)
					return vim.b[buf].neo_tree_source == "filesystem"
				end,
				pinned = true,
				open = function()
					vim.api.nvim_input("<esc><space>e")
				end,
				size = { height = 0.5 },
			},
			{ title = "Neotest Summary", ft = "neotest-summary" },
		}
		opts.animate = { enabled = false }
		-- TODO: Fix keys
		--
		opts.keys = {

			["="] = function(win)
				win:resize("width", 5)
			end,
			["-"] = function(win)
				win:resize("width", -5)
			end,
			["+"] = function(win)
				win:resize("height", 5)
			end,
			["_"] = function(win)
				win:resize("height", -5)
			end,
		}
	end,
}
