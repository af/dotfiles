local KEY_CODES = hs.keycodes.map

-- Override some Ctrl chord mappings to make them more ergonomic
-- In each case this changes a physically convenient mapping that terminals don't
-- support into one that the terminal will accept. As of this writing I use them for tmux
override_handler = function(evt)
  local modifiers = evt:getFlags()
  local keyCode = evt:getKeyCode()
  if not modifiers["ctrl"] then
    return false
  end

  -- map ctrl-; to Home (used for tmux)
  if keyCode == KEY_CODES[";"] then
    evt:setFlags({ctrl=false})
    evt:setKeyCode(KEY_CODES['home'])
  end

  -- map ctrl-' to End (again used for tmux)
  if keyCode == KEY_CODES["'"] then
    evt:setFlags({ctrl=false})
    evt:setKeyCode(KEY_CODES['end'])
  end
end
ctrl_overrides = hs.eventtap.new({hs.eventtap.event.types.keyDown}, override_handler)
ctrl_overrides:start()
