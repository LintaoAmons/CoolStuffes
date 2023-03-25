local hyperKey = { "shift", "alt", "ctrl", "cmd" }

hs.hotkey.bind(hyperKey, "a", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 0.5, 1 })
end)
hs.hotkey.bind(hyperKey, "d", function()
	hs.window.focusedWindow():moveToUnit({ 0.5, 0, 0.5, 1 })
end)
hs.hotkey.bind(hyperKey, "w", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 1, 0.5 })
end)
hs.hotkey.bind(hyperKey, "s", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0.5, 1, 0.5 })
end)

-- full screen
hs.hotkey.bind(hyperKey, "z", function()
	hs.window.focusedWindow():moveToUnit({ 0, 0, 1, 1 })
end)

-- move to another screen
hs.hotkey.bind(hyperKey, "r", function()
	-- get the focused window
	local win = hs.window.focusedWindow()
	-- get the screen where the focused window is displayed, a.k.a. current screen
	local screen = win:screen()
	-- compute the unitRect of the focused window relative to the current screen
	-- and move the window to the next screen setting the same unitRect
	win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

-- Toggle a window between its normal size, and being maximized
local function toggle_window_full_screen()
	local win = hs.window.focusedWindow()
	if win ~= nil then
		win:setFullScreen(not win:isFullScreen())
	end
end

hs.hotkey.bind(hyperKey, "e", toggle_window_full_screen)

-- local switcher = hs.window.switcher.new(hs.window.filter.new():setCurrentSpace(true):setDefaultFilter({}))

-- hs.hotkey.bind(hyperKey, "m", "Next window", function()
-- 	switcher:next()
-- end)
-- hs.hotkey.bind(hyperKey, "n", "Previous window", function()
-- 	switcher:previous()
-- end)

-- -- quarter of screen
-- --[[
--     u i
--     j k
-- --]]
-- hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'u', function() hs.window.focusedWindow():moveToUnit({0, 0, 0.5, 0.5}) end)
-- hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'k', function() hs.window.focusedWindow():moveToUnit({0.5, 0.5, 0.5, 0.5}) end)
-- hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'i', function() hs.window.focusedWindow():moveToUnit({0.5, 0, 0.5, 0.5}) end)
-- hs.hotkey.bind({'ctrl', 'alt', 'cmd'}, 'j', function() hs.window.focusedWindow():moveToUnit({0, 0.5, 0.5, 0.5}) end)
