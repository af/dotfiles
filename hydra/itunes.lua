-- Helper functions for controlling iTunes via AppleScript
--
-- See also:
-- https://gist.github.com/rkumar/503162
-- http://dougscripts.com/itunes/itinfo/info01.php
ext.itunes = {}

function ext.itunes.tell(cmd)
  return os.execute('osascript -e \'tell application "iTunes" to ' .. cmd .. "'")
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
  local artist = shellResult('artist of current track as string')
  local track = shellResult('name of current track as string')
  hydra.alert(track .. artist:gsub('\n', ''), 1.5);
end

function shellResult(command)
  command = 'osascript -e \'tell application "iTunes" to ' .. command .. "'"
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end


-- NOTE: shuffle API is broken in iTunes 11, so these bindings don't work.
-- See https://discussions.apple.com/message/22870402
function ext.itunes.shuffle()
  ext.itunes.tell('set shuffle of current playlist to 1')
end

function ext.itunes.unshuffle()
  ext.itunes.tell('set shuffle of current playlist to 0')
end

