return {
	{
		"L3MON4D3/LuaSnip",
		build = (not jit.os:find("Windows"))
				and "echo 'NOTE: jsregexp is optional, so not a big deal if it fails to build'; make install_jsregexp"
			or nil,
		dependencies = {
			{
				"rafamadriz/friendly-snippets",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
			{
				"nvim-cmp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
				},
				opts = function(_, opts)
					opts.snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					}
					table.insert(opts.sources, { name = "luasnip" })
				end,
			},
		},
		opts = function(_, opts)
			local ls = require("luasnip")
			local types = require("luasnip.util.types")
			ls.setup({
				keep_roots = true,
				link_roots = true,
				link_children = true,

				-- Update more often, :h events for more info.
				update_events = "TextChanged,TextChangedI",
				-- Snippets aren't automatically removed if their text is deleted.
				-- `delete_check_events` determines on which events (:h events) a check for
				-- deleted snippets is performed.
				-- This can be especially useful when `history` is enabled.
				delete_check_events = "TextChanged",
				ext_opts = {
					[types.choiceNode] = {
						active = {
							virt_text = { { "choiceNode", "Comment" } },
						},
					},
				},
				-- treesitter-hl has 100, use something higher (default is 200).
				ext_base_prio = 300,
				-- minimal increase in priority.
				ext_prio_increase = 1,
				enable_autosnippets = true,
				-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
				-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
				store_selection_keys = "<Tab>",
			})

			require("luasnip.loaders.from_lua").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets/lua_snippets" },
			})

			require("luasnip.loaders.from_vscode").lazy_load({
				paths = { vim.fn.stdpath("config") .. "/snippets" },
			})
		end,
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
	},
	-- snippets
	{ "chrisgrieser/nvim-scissors", dependencies = {
		"L3MON4D3/LuaSnip",
	} },
}
