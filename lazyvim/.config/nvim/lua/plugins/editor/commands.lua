vim.api.nvim_create_user_command("Format", function(args)
	local range = nil
	if args.count ~= -1 then
		local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
		range = {
			start = { args.line1, 0 },
			["end"] = { args.line2, end_line:len() },
		}
	end
	require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

function append_empty_lines()
	-- Get the total number of lines in the current buffer
	local line_count = vim.api.nvim_buf_line_count(0)

	-- If the number of lines is less than 10
	if line_count < 10 then
		-- Create a table with 50 empty strings
		local empty_lines = {}
		for i = 1, 50 do
			table.insert(empty_lines, "")
		end

		-- Append the empty lines at the end of the buffer
		vim.api.nvim_buf_set_lines(0, line_count, -1, false, empty_lines)
	end
end

return {
	{
		"LintaoAmons/easy-commands.nvim",
		-- branch = "dev",
		-- dir = "/Volumes/t7ex/Documents/oatnil/release/easy-commands.nvim",
		event = "VeryLazy",
		config = function()
			require("easy-commands").setup({
				disabledCommands = { "Git" }, -- You can disable the commands you don't want
				-- It always welcome to send me back your good commands and usecases
				---@type EasyCommand.Command[]
				myCommands = {
                    {
                        name = "ShowWorkspaceDiagnostics",
                        callback = "Lspsaga show_workspace_diagnostics",
                    },
					{
						name = "TempTerminal",
						callback = function()
							vim.cmd("vsplit")
							vim.cmd("terminal")
							vim.api.nvim_command("startinsert")
						end,
					},
					{
						name = "DeleteEmptyLines",
						callback = "g/^$/d",
						description = "Delete empty lines in the current file",
					},
					{
						name = "DistinctLines",
						callback = "sort u",
					},
					{
						name = "JoinLines",
						callback = "'<,'>s/\v\n/,/",
					},
					{
						name = "TempKeymap",
						callback = function()
							vim.ui.input({ prompt = "write your temp keymap, like: . @q" }, function(msg)
								vim.print("map <buffer> " .. msg)
								vim.api.nvim_command("map <buffer> " .. msg)
							end)
						end,
						description = "Create a buffer local keymap for tmp use",
					},
					{
						name = "GitAmend",
						callback = "G commit --amend",
						dependencies = { "tpope/vim-fugitive" },
					},
					{
						name = "ToggleOutline",
						callback = "AerialToggle",
						dependencies = { "https://github.com/stevearc/aerial.nvim" },
					},
					{
						name = "AddSnippet",
						callback = function()
							require("scissors").addNewSnippet()
						end,
						dependencies = { "https://github.com/chrisgrieser/nvim-scissors" },
					},
					{
						name = "EditSnippet",
						callback = function()
							require("scissors").editSnippet()
						end,
						dependencies = { "https://github.com/chrisgrieser/nvim-scissors" },
					},
				},
				aliases = {
					{
						from = "GitListCommitsOfCurrentFile",
						to = "FileHistory",
					},
					{
						from = "Dired",
						to = "SwitchDirectory",
					},
					{
						from = "DebugStart",
						to = "DebugContinue",
					},
				},
			})
		end,
	},
}
