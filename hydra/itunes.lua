-- Helper functions for controlling iTunes via AppleScript
--
-- See also:
-- https://gist.github.com/rkumar/503162
-- http://dougscripts.com/itunes/itinfo/info01.php
ext.itunes = {}

function ext.itunes.tell(cmd)
  return hydra.exec('osascript -e \'tell application "iTunes" to ' .. cmd .. "'")
end

function ext.itunes.play()
  ext.itunes.tell('playpause')  -- works better than 'play' if iTunes is not yet open
  hydra.alert(' ▶', 0.5)
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
  hydra.alert(track .. '\n' .. album .. '\n' .. artist, 1.5);
end

-- NOTE: iTunes 11's applescript shuffle API is broken, so we have to do crazy
-- gymnastics just to toggle the shuffle setting on/off
-- See https://discussions.apple.com/message/22870402
function ext.itunes.toggleShuffle()
  -- TODO: read the new shuffle setting and use hydra.alert to output it
  -- (rather than the applescript "display dialog" used currently)
  hydra.exec([[osascript -e 'tell application "System Events"
              tell application process "iTunes"
                tell menu 1 of menu item "Shuffle" of menu "Controls" of menu bar 1
                  set menuitems to name of menu items

                  if item 1 of menuitems is "Turn On Shuffle" then
                    click menu item 1
                    display dialog "Shuffle is on"
                  end if
                  if item 1 of menuitems is "Turn Off Shuffle" then
                    click menu item 1
                    display dialog "Shuffle is off"
                  end if
                end tell
              end tell
              end tell']])
end
