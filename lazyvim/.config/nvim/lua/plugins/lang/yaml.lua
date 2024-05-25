-- https://github.com/LazyVim/LazyVim/blob/530e94a9fa19577401e968a9673282c3d79f01e3/lua/lazyvim/plugins/extras/lang/yaml.lua#L26
vim.api.nvim_create_augroup("langYaml", { clear = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "langYaml",
	pattern = {
		"*.yaml",
		"*.yml",
	},
	command = "setlocal shiftwidth=2 tabstop=2",
})

return {

	-- treesitter syntax hightlight
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "yaml" })
			end
		end,
	},

	-- mason lsp,debugger install
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "yaml-language-server")
		end,
	},

	-- yaml schema support
	{
		"b0o/SchemaStore.nvim",
		lazy = true,
		version = false, -- last release is way too old
	},

	-- correctly setup lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				yamlls = {
					-- Have to add this for yamlls to understand that we support line folding
					capabilities = {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					},
					-- lazy-load schemastore when needed
					on_new_config = function(new_config)
						new_config.settings.yaml.schemas = vim.tbl_deep_extend(
							"force",
							new_config.settings.yaml.schemas or {},
							require("schemastore").yaml.schemas()
						)
					end,
					settings = {
						redhat = { telemetry = { enabled = false } },
						yaml = {
							keyOrdering = false,
							format = {
								enable = true,
							},
							validate = true,
							schemaStore = {
								-- Must disable built-in schemaStore support to use
								-- schemas from SchemaStore.nvim plugin
								enable = false,
								-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
								url = "",
							},
						},
					},
				},
			},
			setup = {
				yamlls = function()
					-- Neovim < 0.10 does not have dynamic registration for formatting
					if vim.fn.has("nvim-0.10") == 0 then
						LazyVim.lsp.on_attach(function(client, _)
							if client.name == "yamlls" then
								client.server_capabilities.documentFormattingProvider = true
							end
						end)
					end
				end,
			},
		},
	},
}
