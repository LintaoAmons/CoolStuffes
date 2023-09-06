-- Define the keyboard shortcut to switch to Chrome
local hyperKey = { "shift", "alt", "ctrl", "cmd" }
local shortcuts = {
	["wezTerm"] = "k",
	["Arc"] = "o",
	["Obsidian"] = "j",
	["Finder"] = "l",
	["Visual Studio Code"] = "m", -- this is Visual Studio Code
	["Intellij IDEA"] = "i",
}

local function switchTo(appName)
	local appRunning = hs.application.get(appName)

	if appRunning then
		-- If App is running, activate it
		appRunning:activate()
	else
		-- If App is not running, launch it
		hs.application.launchOrFocus(appName)
	end
end

for appName, shortcut in pairs(shortcuts) do
	hs.hotkey
		.new(hyperKey, shortcut, function()
			switchTo(appName)
		end)
		:enable()
end
