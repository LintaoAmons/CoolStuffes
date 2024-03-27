local set_autocmds = function(autocmds)
	for _, autocmd in ipairs(autocmds) do
		if autocmd[2].group and vim.fn.exists("#" .. autocmd[2].group) == 0 then
			vim.api.nvim_create_augroup(autocmd[2].group, { clear = true })
		end
		vim.api.nvim_create_autocmd(unpack(autocmd))
	end
end

local autocmds = {

	-- Autosave on focus change
	{
		{ "BufLeave", "WinLeave", "FocusLost" },
		{
			pattern = "*",
			group = "Autosave",
			command = "silent! wall",
			nested = true,
		},
	},
	-- {
	-- 	{ "BufLeave", "WinLeave", "FocusLost" },
	-- 	{
	-- 		pattern = "*",
	-- 		group = "Neotree-Gitstatus",
	-- 		callback = function()
	-- 			require("neo-tree.sources.filesystem.commands")
	-- 				-- Call the refresh function found here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/2f2d08894bbc679d4d181604c16bb7079f646384/lua/neo-tree/sources/filesystem/commands.lua#L11-L13
	-- 				.refresh(
	-- 					-- Pull in the manager module. Found here: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/2f2d08894bbc679d4d181604c16bb7079f646384/lua/neo-tree/sources/manager.lua
	-- 					require("neo-tree.sources.manager")
	-- 						-- Fetch the state of the "filesystem" source, feeding it to the filesystem refresh call since most everything in neo-tree
	-- 						-- expects to get its state fed to it
	-- 						.get_state("filesystem")
	-- 				)
	-- 		end,
	-- 		nested = true,
	-- 	},
	-- },
	-- Jump to last accessed window on closing the current one
	{
		{ "WinEnter" },
		{
			pattern = "*",
			group = "WinCloseJmp",
			callback = function()
				if "" ~= vim.api.nvim_win_get_config(0).relative then
					return
				end
				-- Record the window we jump from (previous) and to (current)
				if nil == vim.t.winid_rec then
					vim.t.winid_rec = {
						prev = vim.fn.win_getid(),
						current = vim.fn.win_getid(),
					}
				else
					vim.t.winid_rec = {
						prev = vim.t.winid_rec.current,
						current = vim.fn.win_getid(),
					}
				end
				-- Loop through all windows to check if the
				-- previous one has been closed
				for winnr = 1, vim.fn.winnr("$") do
					if vim.fn.win_getid(winnr) == vim.t.winid_rec.prev then
						return -- Return if previous window is not closed
					end
				end
				vim.cmd("wincmd p")
			end,
		},
	},

	-- Last-position-jump
	{
		{ "BufReadPost" },
		{
			pattern = "*",
			group = "LastPosJmp",
			callback = function(info)
				local ft = vim.bo[info.buf].ft
				-- don't apply to git messages
				if ft:match("commit") or ft:match("rebase") then
					return
				end
				-- get position of last saved edit
				local markpos = vim.api.nvim_buf_get_mark(0, '"')
				local line = markpos[1]
				local col = markpos[2]
				-- if in range, go there
				if (line > 1) and (line <= vim.api.nvim_buf_line_count(0)) then
					vim.api.nvim_win_set_cursor(0, { line, col })
					vim.cmd.normal({ "zvzz", bang = true })
				end
			end,
		},
	},

	-- Show cursor line and cursor column only in current window
	{
		{ "WinEnter" },
		{
			once = true,
			group = "AutoHlCursorLine",
			desc = "Initialize cursorline winhl.",
			callback = function()
				local winlist = vim.api.nvim_list_wins()
				for _, win in ipairs(winlist) do
					vim.api.nvim_win_call(win, function()
						vim.opt_local.winhl:append({
							CursorLine = "",
							CursorColumn = "",
						})
					end)
				end
				return true
			end,
		},
	},
	{
		{ "BufWinEnter", "WinEnter", "InsertLeave" },
		{
			group = "AutoHlCursorLine",
			callback = function()
				vim.defer_fn(function()
					local winhl = vim.opt_local.winhl:get()
					-- Restore CursorLine and CursorColumn for current window
					-- if diff is not and not in inert/replace/select mode
					if
						not vim.wo.diff
						and (winhl["CursorLine"] or winhl["CursorColumn"])
						and vim.fn.match(vim.fn.mode(), "[iRsS\x13].*") == -1
					then
						vim.opt_local.winhl:remove({
							"CursorLine",
							"CursorColumn",
						})
					end
					-- Conceal cursor line and cursor column in the previous window
					-- if current window is a normal window
					local current_win = vim.api.nvim_get_current_win()
					local prev_win = vim.fn.win_getid(vim.fn.winnr("#"))
					if
						prev_win ~= 0
						and prev_win ~= current_win
						and vim.api.nvim_win_is_valid(prev_win)
						and vim.fn.win_gettype(current_win) == ""
					then
						vim.api.nvim_win_call(prev_win, function()
							vim.opt_local.winhl:append({
								CursorLine = "",
								CursorColumn = "",
							})
						end)
					end
				end, 10)
			end,
		},
	},
	{
		{ "InsertEnter" },
		{
			group = "AutoHlCursorLine",
			callback = function()
				vim.opt_local.winhl:append({
					CursorLine = "",
					CursorColumn = "",
				})
			end,
		},
	},

	-- Disable winbar in diff mode
	{
		{ "OptionSet" },
		{
			pattern = "diff",
			group = "DisableWinBarInDiffMode",
			callback = function()
				if vim.v.option_new == "1" then
					vim.w._winbar = vim.wo.winbar
					vim.wo.winbar = nil
				else
					vim.wo.winbar = vim.w._winbar
				end
			end,
		},
	},
}

set_autocmds(autocmds)

local function save()
	local buf = vim.api.nvim_get_current_buf()

	vim.api.nvim_buf_call(buf, function()
		vim.cmd("silent! write")
	end)
end

function ToggleAutoSave()
	local flag = vim.g.easy_command_auto_save or false
	if flag then
		vim.g.easy_command_auto_save = false
		vim.api.nvim_del_augroup_by_name("AutoSave")
	else
		vim.api.nvim_create_augroup("AutoSave", {
			clear = true,
		})
		vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
			callback = function()
				save()
			end,
			pattern = "*",
			group = "AutoSave",
		})
		vim.g.easy_command_auto_save = true
	end
end

ToggleAutoSave()

-- HACK: don't wrap in markdown
-- vim.api.nvim_create_augroup("lazyvim_wrap_spell", {clear = true})

vim.cmd([[ autocmd BufNewFile,BufRead *.hurl set filetype=hurl ]])

vim.cmd([[ autocmd BufNewFile,BufRead *.mdx set filetype=md ]])
