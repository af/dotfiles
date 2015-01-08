local grid = require "grid"
local itunes_custom = require "itunes"

-- TODO: replace Spark.app (volume ctrl w/ F13-15)

-- Reload automatically on config changes
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.alert.show("Hammerspoon is locked and loaded", 1)

hs.window.animationDuration = 0     -- Disable window animations (janky for iTerm)

local mash = {"ctrl", "alt", "cmd"}

-- Hammerspoon repl:
hs.hotkey.bind(mash, 'C', hs.openConsole)

-- Window management
hs.hotkey.bind(mash, 'K', grid.fullscreen)
hs.hotkey.bind(mash, 'H', grid.leftchunk)
hs.hotkey.bind(mash, 'L', grid.rightchunk)
hs.hotkey.bind(mash, 'P', grid.pushwindow)

hs.hotkey.bind(mash, 'N', grid.topleft)
hs.hotkey.bind(mash, 'M', grid.bottomleft)
hs.hotkey.bind(mash, ',', grid.topright)
hs.hotkey.bind(mash, '.', grid.bottomright)


-- iTunes control
hs.hotkey.bind(mash, 'UP', hs.itunes.play)
hs.hotkey.bind(mash, 'DOWN', hs.itunes.pause)
hs.hotkey.bind(mash, 'LEFT', hs.itunes.previous)
hs.hotkey.bind(mash, 'RIGHT', hs.itunes.next)
hs.hotkey.bind(mash, '/', hs.itunes.displayCurrentTrack)
hs.hotkey.bind(mash, 'S', itunes_custom.toggleShuffle)


-- Launch/focus specific apps with one keystroke.
-- Note: to get {^1,^2,^3} to work, you might need to change some conflicting
-- Mission Control keyboard shortcuts in SysPrefs > Keyboard > Shortcuts
hs.hotkey.bind({"ctrl"}, '1', function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({"ctrl"}, '2', function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind({"ctrl"}, '3', function() hs.application.launchOrFocus("iTunes") end)
hs.hotkey.bind({"ctrl"}, '4', function() hs.application.launchOrFocus("Slack") end)
