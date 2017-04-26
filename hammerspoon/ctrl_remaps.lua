local event = require('hs.eventtap').event
local KEY_CODES = hs.keycodes.map

-- Send a keystroke without the delay that hs.eventtap.keyStroke() imposes
-- modified from https://github.com/Hammerspoon/hammerspoon/issues/1011#issuecomment-261114434
keyStroke = function(modifiers, key)
  event.newKeyEvent(modifiers, key, true):post()
  event.newKeyEvent(modifiers, key, false):post()
end

hs.hotkey.bind({'ctrl'}, KEY_CODES[';'], nil, (function()
  keyStroke({}, KEY_CODES['home'])
end), nil)

hs.hotkey.bind({'ctrl'}, KEY_CODES["'"], nil, (function()
  keyStroke({}, KEY_CODES['end'])
end), nil)
