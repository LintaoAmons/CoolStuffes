local wezterm = require("wezterm")
local act = wezterm.action

-- https://github.com/folke/zen-mode.nvim
wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

local function macCMDtoMeta()
	local keys = "abdefghijklmnopqrstuwxyz1234567890/" -- no c,v
	local keymappings = {}

	for i = 1, #keys do
		local c = keys:sub(i, i)

    -- CMD+key  -->  META+key
		table.insert(keymappings, {
			key = c,
			mods = "CMD",
			action = act.SendKey({
				key = c,
				mods = "META",
			}),
		})

    -- CMD+CTRL+key  -->  META+key
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
		{
			key = "F2",
			mods = "CMD",
			action = act.SendKey({
				key = "F2",
				mods = "META",
			}),
		},
	}

	for _, v in ipairs(macCMDtoMeta()) do
		table.insert(keymappings, v)
	end
	return keymappings
end

return {
	font = wezterm.font_with_fallback({
		-- "FiraMono Nerd Font Mono",
		"Hack Nerd Font Mono",
	}),
	color_scheme = "Gruvbox dark, medium (base16)",
	keys = generateKeyMappings(),
	font_size = 18.0,
	hide_tab_bar_if_only_one_tab = true,
}
