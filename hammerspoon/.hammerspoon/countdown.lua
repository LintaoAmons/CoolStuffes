local remindTimer = nil

function remindUser()
    hs.notify.new({
        title = "Reminder",
        informativeText = "Time is up!",
        soundName = "Glass"
    }):send()
    remindTimer = nil -- set timer object to nil so that it can be restarted later
end

function startRemindTimer()
    -- Ask the user for input
    local ok, result = hs.dialog.textPrompt("Remind Timer", "Enter the number of minutes:", "20")

    if ok then
        -- Convert the user input to a number
        local minutes = tonumber(result)

        if minutes ~= nil then
            -- Start the timer
            remindTimer = hs.timer.doAfter(minutes * 60, remindUser)

            -- Wait for 300ms before focusing on the popup window
            hs.focus()
        else
            hs.alert.show("Invalid input, please enter a number.")
        end
    end
end

function stopRemindTimer()
    if remindTimer ~= nil then
        remindTimer:stop()
        hs.notify.new({
            title = "Reminder",
            informativeText = "Timer Cancelled",
            soundName = "Glass"
        }):send()
        remindTimer = nil
    else
        hs.notify.new({
            title = "Reminder",
            informativeText = "No Timer to cancel",
            soundName = "Glass"
        }):send()
    end
end

-- Set a hotkey to start the timer
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "R", startRemindTimer)

-- Set a hotkey to stop the timer
hs.hotkey.bind({"cmd", "ctrl", "alt"}, "S", stopRemindTimer)
