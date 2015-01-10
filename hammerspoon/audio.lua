local Audio = {}
local VOLUME_MIN = 0
local VOLUME_MAX = 100
local VOLUME_STEP = 5

-- display a unicode volume meter via hs.alert
-- Characters found via http://changaco.net/unicode-progress-bars/
local showVolumeAlert = function(volume)
  -- show a 20-bar volume meter (5% increments)
  local numBars = math.floor(volume/5)
  local numSpaces = 20 - numBars
  local volumeBar = string.rep('⣿', numBars) .. string.rep('⣀', numSpaces)
  hs.alert(volumeBar)
end

Audio.toggleMute = function()
  local device = hs.audiodevice.defaultOutputDevice()
  local wasMuted = device:muted()
  device:setMuted(not wasMuted)
  showVolumeAlert(wasMuted and device:volume() or 0)
end

Audio.decVolume = function()
  local device = hs.audiodevice.defaultOutputDevice()
  local targetVolume = math.max(device:volume() - VOLUME_STEP, VOLUME_MIN)
  device:setMuted(false)
  device:setVolume(targetVolume)
  showVolumeAlert(targetVolume)
end

Audio.incVolume = function()
  local device = hs.audiodevice.defaultOutputDevice()
  local targetVolume = math.min(device:volume() + VOLUME_STEP, VOLUME_MAX)
  device:setMuted(false)
  device:setVolume(targetVolume)
  showVolumeAlert(targetVolume)
end

return Audio
