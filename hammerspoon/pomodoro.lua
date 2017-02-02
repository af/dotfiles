-- WIP pomodoro menubar timer
--
-- Resources:
-- https://learnxinyminutes.com/docs/lua/
-- http://www.hammerspoon.org/docs/hs.menubar.html
-- http://www.hammerspoon.org/docs/hs.timer.html#doEvery
--
-- TODO:
-- * setup timer for break time
-- * make latest tasks alert styleable and toggleable

local menu = hs.menubar.new()
local currentPomo = nil

local TIMER_INTERVAL = 60       -- 60 (one minute) for real use; set lower for debugging
local POMO_LENGTH = 25          -- Length in minutes of one work interval
local LOG_FILE = '~/.pomo'

-- Namespace tables
local Commands = {}
local Log = {}
local App = {}

Log.read = function(count)
    if not count then count = 10 end
    return hs.execute('tail -' .. count .. ' ' .. LOG_FILE)
end

Log.writeItem = function(pomo)
    local timestamp = os.date('%Y-%m-%d %T')
    local isFirstToday = #(Log.getCompletedToday()) == 0

    if (isFirstToday) then hs.execute('echo "" >> ' .. LOG_FILE) end  -- Add linebreak between days
    hs.execute('echo "[' .. timestamp .. '] ' .. pomo.name .. '" >> ' .. LOG_FILE)
end

Log.getLatestItems = function(count)
    local logs = Log.read(count)
    local logItems = {}
    for match in logs:gmatch('(.-)\r?\n') do table.insert(logItems, match) end
    return logItems
end

Log.getCompletedToday = function()
    local logItems = Log.getLatestItems(20)
    local timestamp = os.date('%Y-%m-%d')
    local todayItems = hs.fnutils.filter(logItems, function(s)
        return string.find(s, timestamp, 1, true) ~= nil
    end)
    return todayItems
end

Log.getLastTask = function()
    local taskWithTimestamp = Log.getLatestItems(1)[1]
    if not taskWithTimestamp then return '' end

    local taskStartPosition = string.find(taskWithTimestamp, ']') + 2
    return string.sub(taskWithTimestamp, taskStartPosition)
end

Commands.startNew = function()
    local defaultName = Log.getLastTask()
    if currentPomo then defaultName = currentPomo.name end
    taskName = App.showDialog('What are you working on?', defaultName)
    if taskName then
        currentPomo = {minutesLeft=POMO_LENGTH, name=taskName}
    end
    App.updateUI()
end

Commands.togglePaused = function()
    if not currentPomo then return end
    currentPomo.paused = not currentPomo.paused
    App.updateUI()
end

Commands.showLatest = function()
    local logs = Log.read(10)
    local displayDuration = 5
    hs.alert('LATEST ACTIVITY\n\n' .. logs, displayDuration)
end

App.complete = function(pomo)
    Log.writeItem(pomo)
    currentPomo = nil
end

App.timerCallback = function()
    if not currentPomo then return end
    if currentPomo.paused then return end
    currentPomo.minutesLeft = currentPomo.minutesLeft - 1
    if (currentPomo.minutesLeft <= 0) then
        App.complete(currentPomo)
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
    local title = '🍅'
    if pomo then
        title = title .. ('0:' .. string.format('%02d', pomo.minutesLeft))
        if pomo.paused then
            title = title .. ' (paused)'
        end
    end
    return title
end

App.updateUI = function()
    menu:setTitle(App.getMenubarTitle(currentPomo))
end

App.init = function()
    hs.timer.doEvery(TIMER_INTERVAL, App.timerCallback)

    menu:setMenu(function()
        local completedCount = #(Log.getCompletedToday())
        return {
          -- TODO: make these menu items contextual:
          { title=completedCount .. ' pomos completed today', disabled=true },
          { title='Start', fn=Commands.startNew },
          { title='Pause', fn=Commands.togglePaused }
        }
    end)

    App.updateUI()
end

App.init()

return Commands
