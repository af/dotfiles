-- Extra helper functions for controlling iTunes via AppleScript
itunes = {}

-- New shuffle implementation for iTunes 12 (the menu is different from prev. versions)
-- adapted from https://discussions.apple.com/thread/6573883
function itunes.toggleShuffle()
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
  hs.alert.show(shuffleStatus, 1.0)
end

return itunes
