local wezterm = require("wezterm")
local act = wezterm.action

local function macCMDtoMeta()
	local keys = "abdefghijklmnopqrstuwxyz38" -- no c,v
	local keymappings = {}

	for i = 1, #keys do
		local c = keys:sub(i, i)
		table.insert(keymappings, {
			key = c,
			mods = "CMD",
			action = act.SendKey({
				key = c,
				mods = "META",
			}),
		})
		table.insert(keymappings, {
			key = c,
			mods = "CMD|CTRL",
			action = act.SendKey({
				key = c,
				mods = "META|CTRL",
			}),
		})
	end
	return keymappings
end

local function generateKeyMappings()
	local keymappings = {
		{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.SpawnWindow },
	}

	for _, v in ipairs(macCMDtoMeta()) do
		table.insert(keymappings, v)
	end
	return keymappings
end

return {
	font = wezterm.font_with_fallback({
		"Hack Nerd Font Mono",
	}),
	color_scheme = "Gruvbox dark, medium (base16)",
	keys = generateKeyMappings(),

	font_size = 18.0,
	hide_tab_bar_if_only_one_tab = true,
}

