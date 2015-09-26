local Audio = require 'audio'
local Grid = require 'grid'
local Music = require 'itunes'


-- Reload automatically on config changes
hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', hs.reload):start()
hs.alert('Hammerspoon is locked and loaded', 1)

hs.window.animationDuration = 0     -- Disable window animations (janky for iTerm)

local mash = {'ctrl', 'alt', 'cmd'}

-- Hammerspoon repl:
hs.hotkey.bind(mash, 'C', hs.openConsole)

-- Window management
hs.hotkey.bind(mash, 'K', Grid.fullscreen)
hs.hotkey.bind(mash, 'H', Grid.leftchunk)
hs.hotkey.bind(mash, 'L', Grid.rightchunk)
hs.hotkey.bind(mash, 'J', Grid.pushwindow)

hs.hotkey.bind(mash, 'N', Grid.topleft)
hs.hotkey.bind(mash, 'M', Grid.bottomleft)
hs.hotkey.bind(mash, ',', Grid.topright)
hs.hotkey.bind(mash, '.', Grid.bottomright)
hs.hotkey.bind(mash, 'P', Grid.rightpeek)


-- iTunes control
hs.hotkey.bind(mash, 'UP', hs.itunes.play)
hs.hotkey.bind(mash, 'DOWN', hs.itunes.pause)
hs.hotkey.bind(mash, 'LEFT', hs.itunes.previous)
hs.hotkey.bind(mash, 'RIGHT', hs.itunes.next)
hs.hotkey.bind(mash, '/', hs.itunes.displayCurrentTrack)
hs.hotkey.bind(mash, 'S', Music.toggleShuffle)


-- Launch/focus specific apps with one keystroke.
-- Note: to get {^1,^2,^3} to work, you might need to change some conflicting
-- Mission Control keyboard shortcuts in SysPrefs > Keyboard > Shortcuts
hs.hotkey.bind({'ctrl'}, '1', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind({'ctrl'}, '2', function() hs.application.launchOrFocus('iTerm') end)
hs.hotkey.bind({'ctrl'}, '3', function() hs.application.launchOrFocus('iTunes') end)
hs.hotkey.bind({'ctrl'}, '4', function() hs.application.launchOrFocus('Slack'); Grid.leftchunk(); end)
hs.hotkey.bind({'ctrl'}, '5', function() hs.application.launchOrFocus('Finder') end)


-- Audio volume control
hs.hotkey.bind({}, 'F13', Audio.toggleMute)
hs.hotkey.bind({}, 'F14', Audio.decVolume)
hs.hotkey.bind({}, 'F15', Audio.incVolume)
