-- WIP pomodoro menubar timer
--
-- Resources:
-- https://learnxinyminutes.com/docs/lua/
-- http://www.hammerspoon.org/docs/hs.menubar.html
-- http://www.hammerspoon.org/docs/hs.timer.html#doEvery
--
-- TODO:
-- * implement pause/stop
-- * setup timer for break time
-- * global hotkeys for all controls
-- * linebreak in log file for new day

local menu = hs.menubar.new()
local completedPomos = {}
local currentPomo = nil

local TIMER_INTERVAL = 60       -- 60 (one minute) for real use; set lower for debugging
local POMO_LENGTH = 25
local LOG_FILE = '~/.pomo'

-- Namespace tables
local Pomo = {}
local App = {}

-- TODO: move UI-related code out of the Pomo namespace
Pomo.startNew = function()
    local defaultName = ''
    if currentPomo then defaultName = currentPomo.name end
    taskName = App.showDialog('what are you working on?', defaultName)
    if taskName then
        currentPomo = {minutesLeft=POMO_LENGTH, name=taskName}
    end
    App.updateUI()
end

Pomo.complete = function(pomo)
    local timestamp = os.date('%Y-%m-%d %T')
    table.insert(completedPomos, pomo)
    hs.execute('echo "[' .. timestamp .. '] ' .. pomo.name .. '" >> ' .. LOG_FILE)
    currentPomo = nil
end


App.timerCallback = function()
    if not currentPomo then return end
    currentPomo.minutesLeft = currentPomo.minutesLeft - 1
    if (currentPomo.minutesLeft <= 0) then
        Pomo.complete(currentPomo)
        hs.alert('You are done!')
        hs.execute('say "done zo"')
    end
    App.updateUI()
end

App.showDialog = function(prompt, defaultText)
    defaultText = defaultText or ''
    local success, text = hs.applescript([[
      display dialog "]] .. prompt .. [[" default answer "]] .. defaultText .. [["
      return (text returned of result)
    ]])
    if not success then
        return nil
    end
    return text
end

App.getMenubarTitle = function(pomo)
    if (pomo == nil) then return '🍅-'
    else return '🍅0:' .. string.format('%02d', pomo.minutesLeft)
    end
end

App.updateUI = function()
    menu:setTitle(App.getMenubarTitle(currentPomo))
end

App.init = function()
    hs.timer.doEvery(TIMER_INTERVAL, App.timerCallback)

    menu:setMenu(function()
        local completedCount = #completedPomos      -- TODO: read from log file instead
        return {
          -- TODO: make these menu items contextual:
          { title=completedCount .. ' pomos completed today', disabled=true },
          { title='Start', fn=Pomo.startNew },
          { title='Pause' }
        }
    end)

    App.updateUI()
end

App.init()

hs.hotkey.bind({}, 'F16', Pomo.startNew)
