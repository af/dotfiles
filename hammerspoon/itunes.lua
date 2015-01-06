-- Helper functions for controlling iTunes via AppleScript
--
-- See also:
-- https://gist.github.com/rkumar/503162
-- http://dougscripts.com/itunes/itinfo/info01.php
ext.itunes = {}

function ext.itunes.tell(cmd)
  return hs.applescript('tell application "iTunes" to ' .. cmd)
end

function ext.itunes.play()
  ext.itunes.tell('playpause')  -- works better than 'play' if iTunes is not yet open
  hs.alert.show(' ▶', 0.5)
end

function ext.itunes.pause()
  ext.itunes.tell('pause')
end

function ext.itunes.next()
  ext.itunes.tell('next track')
end

function ext.itunes.previous()
  ext.itunes.tell('previous track')
end

function ext.itunes.currentTrack()
  local artist = ext.itunes.tell('artist of current track as string')
  local album = ext.itunes.tell('album of current track as string')
  local track = ext.itunes.tell('name of current track as string')
  hs.alert.show(track .. '\n' .. album .. '\n' .. artist, 1.5);
end

-- New shuffle implementation for iTunes 12 (the menu is different from prev. versions)
-- adapted from https://discussions.apple.com/thread/6573883
function ext.itunes.toggleShuffle()
  local succes, shuffleStatus = hs.applescript([[tell application "System Events"
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
