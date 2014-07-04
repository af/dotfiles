require "grid"

hydra.alert("Hydra config loaded", 0.5)

pathwatcher.new(os.getenv("HOME") .. "/.hydra/", hydra.reload):start()
autolaunch.set(true)

local ctrlaltcmd = {"ctrl", "alt", "cmd"}
local ctrlcmd = {"ctrl", "cmd"}

hotkey.bind(ctrlcmd, 'K', ext.grid.fullscreen)
hotkey.bind(ctrlcmd, 'H', ext.grid.leftchunk)
hotkey.bind(ctrlcmd, 'L', ext.grid.rightchunk)
hotkey.bind(ctrlcmd, 'P', ext.grid.pushwindow)

hotkey.bind(ctrlcmd, 'N', ext.grid.topleft)
hotkey.bind(ctrlcmd, 'M', ext.grid.bottomleft)
hotkey.bind(ctrlcmd, ',', ext.grid.topright)
hotkey.bind(ctrlcmd, '.', ext.grid.bottomright)
hotkey.bind(ctrlaltcmd, 'R', function() repl.open(); logger.show() end)

-- Shortcut to launch/focus specific apps with one keystroke.
--
-- Note 1: you might need to change some conflicting Mission Control keyboard
-- shortcuts in SysPrefs > Keyboard > Shortcuts to get ^1 ^2 ^3 to work.
-- Note 2: using launchorfocus("Google Chrome") doesn't work, so use the raw version:
hotkey.bind({"ctrl"}, '1', function() os.execute('open -a "Google Chrome"') end)
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
