-- Grab bag of useful commands and applescript
local utils = {}


-- Use OS X notifications for a more pleasant current track alert
-- TODO: figure out how to show the album art in this alert as well
utils.musicTrackAlert = function()
  local artist = hs.itunes.getCurrentArtist() or "Unknown artist"
  local album  = hs.itunes.getCurrentAlbum() or "Unknown album"
  local track  = hs.itunes.getCurrentTrack() or "Unknown track"
  local n = hs.notify.new({title=track, subTitle=artist, informativeText=album})
  n:hasActionButton(false)
  n:send()

  -- Withdraw the notification after a few seconds.
  -- n:autoWithdraw(true) would suffice in theory, but if Hammerspoon notifications are set to
  -- "Alert" in OS X, autoWithdraw will not work.
  hs.timer.doAfter(3, function() n:withdraw() end)
end


-- New shuffle implementation for Music.app
utils.toggleShuffle = function()
  local tell = function(cmd) return hs.applescript('tell application "Music" to ' .. cmd) end
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
