vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#FF0000", bg = "#FF0000" })
vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#FBF3CB", bg = "#FF007C" })
vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#000000" })

return {
	{
		"miversen33/sunglasses.nvim",
		-- enabled = false,
		config = function()
			local sunglasses_options = {
				filter_percent = 0.65,
				filter_type = "NOSYNTAX",
			}

			require("sunglasses").setup(sunglasses_options)
		end,
		event = "UIEnter",
	},
	{
		"folke/edgy.nvim",
		opts = function(_, opts)
			opts.animate = { enabled = false }
			-- TODO: Fix keys
			--
			opts.keys["="] = function(win)
				win:resize("width", 5)
			end
			opts.keys["-"] = function(win)
				win:resize("width", -5)
			end
			opts.keys["+"] = function(win)
				win:resize("height", 5)
			end
			opts.keys["_"] = function(win)
				win:resize("height", -5)
			end
		end,
	},
	{
		"folke/twilight.nvim",
		-- enabled = false,
		event = "VeryLazy",
		config = function()
			require("twilight").setup({
				dimming = {
					alpha = 0.25, -- amount of dimming
					-- we try to get the foreground from the highlight groups or fallback color
					color = { "Normal", "#ffffff" },
					term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
					inactive = true, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
					expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
						-- "function",
						-- "method",
						-- "table",
						-- "if_statement",
						-- "for_statement",
					},
				},
			})
			-- vim.cmd("Twilight") enable Twilight at vim startup
		end,
	},
	-- -- add gruvbox
	-- { "ellisonleao/gruvbox.nvim" },
	--
	-- -- Configure LazyVim to load gruvbox
	-- {
	--   "LazyVim/LazyVim",
	--   opts = {
	--     colorscheme = "gruvbox",
	--   },
	-- },
	--

	-- { "savq/melange-nvim" },

	{
		"malbernaz/monokai.nvim",
		config = function()
			require("monokai").setup({
				custom_hlgroups = {
					FlashCurrent = { fg = "#FF0000", bg = "#FF0000" },
					FlashLabel = { fg = "#FBF3CB", bg = "#FF007C" },
					FlashMatch = { fg = "#000000", bg = "#000000" },
				},
			})
		end,
	},
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "monokai",
		},
	},
}
