-- Grab bag of useful commands and applescript
local utils = {}

local function tellItunes(cmd)
    local _cmd = 'tell application "iTunes" to ' .. cmd
    local ok, result = hs.applescript(_cmd)
    if ok then
        return result
    else
        return nil
    end
end

-- Use OS X notifications for a more pleasant current track alert
-- TODO: figure out how to show the album art in this alert as well
utils.itunesTrackAlert = function()
    local artist = tellItunes('artist of the current track as string') or "Unknown artist"
    local album  = tellItunes('album of the current track as string') or "Unknown album"
    local track  = tellItunes('name of the current track as string') or "Unknown track"
    local n = hs.notify.new({title=track, subTitle=artist, informativeText=album})
    n:hasActionButton(false)
    n:send()

    -- Withdraw the notification after a few seconds.
    -- n:autoWithdraw(true) would suffice in theory, but if Hammerspoon notifications are set to
    -- "Alert" in OS X, autoWithdraw will not work.
    hs.timer.doAfter(3, function() n:withdraw() end)
end


-- New shuffle implementation for iTunes 12.5+
--
-- Note: previous implementation had to scrape the menus, and was
-- adapted from https://discussions.apple.com/thread/6573883
utils.toggleItunesShuffle = function()
    local tell = function(cmd) return hs.applescript('tell application "iTunes" to ' .. cmd) end
    local success, shuffleStatus = tell('get shuffle enabled')
    if shuffleStatus then
        tell('set shuffle enabled to false')
        hs.alert('shuffle disabled')
    else
        tell('set shuffle enabled to true')
        hs.alert('shuffle enabled')
    end
end


-- Close all open notifications
-- Note that binding this to a keystroke with modifiers (Cmd/Shift/Ctrl) seems to not work
-- Found via http://www.genuinecuriosity.com/genuinecuriosity/2016/6/5/clear-away-multiple-os-x-alerts-with-a-keystroke
utils.dismissAllNotifications = function()
    local success, result = hs.applescript([[
        tell application "System Events"
        tell process "Notification Center"
            set theWindows to every window
            repeat with i from 1 to number of items in theWindows
                set this_item to item i of theWindows
                try
                    click button 1 of this_item
                end try
            end repeat
        end tell
    end tell
    ]])
end

return utils
