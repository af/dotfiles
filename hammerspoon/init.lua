require "grid"
require "itunes"

-- TODO: review docs at http://www.hammerspoon.org/docs/
-- TODO: repl shortcut?

-- TODO: replace Spark.app (volume ctrl w/ F13-15)
-- TODO: iTunes shuffle/playlist control


hs.alert.show("Hammerspoon is locked and loaded", 1)
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()

hs.window.animationDuration = 0     -- Disable window animations (janky for iTerm)

local mash = {"ctrl", "alt", "cmd"}


-- Window management
hs.hotkey.bind(mash, 'K', ext.grid.fullscreen)
hs.hotkey.bind(mash, 'H', ext.grid.leftchunk)
hs.hotkey.bind(mash, 'L', ext.grid.rightchunk)
hs.hotkey.bind(mash, 'P', ext.grid.pushwindow)

hs.hotkey.bind(mash, 'N', ext.grid.topleft)
hs.hotkey.bind(mash, 'M', ext.grid.bottomleft)
hs.hotkey.bind(mash, ',', ext.grid.topright)
hs.hotkey.bind(mash, '.', ext.grid.bottomright)
--hs.hotkey.bind(mash, 'R', repl.open)


-- iTunes control
hs.hotkey.bind(mash, 'UP', ext.itunes.play)
hs.hotkey.bind(mash, 'DOWN', ext.itunes.pause)
hs.hotkey.bind(mash, 'LEFT', ext.itunes.previous)
hs.hotkey.bind(mash, 'RIGHT', ext.itunes.next)
hs.hotkey.bind(mash, '/', ext.itunes.currentTrack)
hs.hotkey.bind(mash, 'S', ext.itunes.toggleShuffle)


-- Launch/focus specific apps with one keystroke.
-- Note: to get {^1,^2,^3} to work, you might need to change some conflicting
-- Mission Control keyboard shortcuts in SysPrefs > Keyboard > Shortcuts
hs.hotkey.bind({"ctrl"}, '1', function() hs.application.launchOrFocus("Google Chrome") end)
hs.hotkey.bind({"ctrl"}, '2', function() hs.application.launchOrFocus("iTerm") end)
hs.hotkey.bind({"ctrl"}, '4', function() hs.application.launchOrFocus("Slack") end)
hs.hotkey.bind({"ctrl"}, '0', function() hs.application.launchOrFocus("iTunes") end)
-- TODO: hotkey to bind to a new ^# mapping dynamically (eg. ^6 => "preview")
