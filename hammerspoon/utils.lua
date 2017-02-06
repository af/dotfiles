-- Grab bag of useful commands and applescript
local utils = {}

-- New shuffle implementation for iTunes 12 (the menu is different from prev. versions)
-- adapted from https://discussions.apple.com/thread/6573883
-- Note: appears to only work while music is playing?
utils.toggleItunesShuffle = function()
  local success, shuffleStatus = hs.applescript([[tell application "System Events"
    tell application process "iTunes"
      set shuffleOn to (value of attribute "AXMenuItemMarkChar" of menu item "On" of menu "Shuffle" of menu item "Shuffle" of menu "Controls" of menu bar 1) as string
      if shuffleOn is "✓" then
        click menu item "Off" of menu "Shuffle" of menu item "Shuffle" of menu "Controls" of menu bar 1
        return "Shuffle is OFF"
      else
        click menu item "On" of menu "Shuffle" of menu item "Shuffle" of menu "Controls" of menu bar 1
        return "Shuffle is ON"
      end if
    end tell
    end tell
  ]])
  hs.alert(shuffleStatus, 1.0)
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
