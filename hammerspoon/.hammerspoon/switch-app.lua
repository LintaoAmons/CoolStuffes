-- Define the keyboard shortcut to switch to Chrome
local hyperKey = { "shift", "alt", "ctrl", "cmd" }
local shortcuts = {
	["Google Chat.app"] = "g",
	["Google Chrome.app"] = "f",
	["Neovide"] = "j",
	["Obsidian"] = "h",
	["wezTerm"] = "k",
	["Finder"] = "l",
	["Intellij IDEA"] = "i",
	["Arc"] = "o",
	["Excalidraw.app"] = "n",
	["Visual Studio Code"] = "m", -- this is Visual Studio Code
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
