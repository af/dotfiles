require "grid"
require "itunes"

-- TODO: replace Spark.app (volume ctrl w/ F13-15)
-- TODO: iTunes shuffle/playlist control


hydra.alert("Hydra is locked and loaded", 1)
pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()
autolaunch.set(true)

local mash = {"ctrl", "alt", "cmd"}


-- Window management
hotkey.bind(mash, 'K', ext.grid.fullscreen)
hotkey.bind(mash, 'H', ext.grid.leftchunk)
hotkey.bind(mash, 'L', ext.grid.rightchunk)
hotkey.bind(mash, 'P', ext.grid.pushwindow)

hotkey.bind(mash, 'N', ext.grid.topleft)
hotkey.bind(mash, 'M', ext.grid.bottomleft)
hotkey.bind(mash, ',', ext.grid.topright)
hotkey.bind(mash, '.', ext.grid.bottomright)
hotkey.bind(mash, 'R', function() repl.open(); end)


-- iTunes control
hotkey.bind(mash, 'UP', ext.itunes.play)
hotkey.bind(mash, 'DOWN', ext.itunes.pause)
hotkey.bind(mash, 'LEFT', ext.itunes.previous)
hotkey.bind(mash, 'RIGHT', ext.itunes.next)
hotkey.bind(mash, '/', ext.itunes.currentTrack)


-- Launch/focus specific apps with one keystroke.
-- Note: to get {^1,^2,^3} to work, you might need to change some conflicting
-- Mission Control keyboard shortcuts in SysPrefs > Keyboard > Shortcuts
hotkey.bind({"ctrl"}, '1', function() application.launchorfocus("Google Chrome") end)
hotkey.bind({"ctrl"}, '2', function() application.launchorfocus("MacVim") end)
hotkey.bind({"ctrl"}, '3', function() application.launchorfocus("iTerm") end)
hotkey.bind({"ctrl"}, '4', function() application.launchorfocus("Slack") end)
hotkey.bind({"ctrl"}, '0', function() application.launchorfocus("iTunes") end)


-- simple customized menu for the OS X menubar:
menu.show(function()
    return {
      {title = "Reload Config", fn = hydra.reload},
      {title = "-"},
      {title = "About", fn = hydra.showabout},
      {title = "Quit Hydra", fn = os.exit},
    }
end)
