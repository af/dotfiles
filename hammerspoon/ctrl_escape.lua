-- Make Ctrl key dual-purpose, acting as Esc on tap
-- This is intended to be used alongside a CapsLock that's mapped to Ctrl in OS X
-- Originally adapted from https://github.com/jasoncodes/dotfiles/blob/master/hammerspoon/control_escape.lua
-- as of d619ce0 (on Oct 28, 2016)
local send_escape = false
local last_mods = {}

local control_key_timer = hs.timer.delayed.new(0.15, function()
  send_escape = false
end)

-- Need to bind to global variables to prevent garbage collection from cleaning up these eventtap bindings
GLOBAL_FLAGSCHANGED = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then return false end
  if not last_mods["ctrl"] then
    last_mods = new_mods
    send_escape = true
    control_key_timer:start()
  else
    if send_escape then hs.eventtap.keyStroke({}, "ESCAPE") end
    last_mods = new_mods
    control_key_timer:stop()
  end
  return false
end):start()

GLOBAL_KEYDOWN = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function()
  send_escape = false
  return false
end):start()
