-- WIP pomodoro menubar timer
--
-- Notes:
-- * You want to set your Hammerspoon notification settings to Alert
--   if you wish to make the notifications dismissable
--
-- Resources:
-- https://learnxinyminutes.com/docs/lua/
-- http://www.hammerspoon.org/docs/hs.menubar.html
-- http://www.hammerspoon.org/docs/hs.timer.html#doEvery

local menu = hs.menubar.new()
local currentPomo = nil
local alertId = nil

local TIMER_INTERVAL = 60       -- 60 (one minute) for real use; set lower for debugging
local POMO_LENGTH = 25          -- Length in minutes of one work interval
local LOG_FILE = '~/.pomo'

-- Namespace tables
local Commands = {}
local Log = {}
local App = {}

-- (ab)use hs.chooser as a text input with the possibility of using other options
local showChooserPrompt = function(options, callback)
    local chooser = hs.chooser.new(function(item)
        callback(item.text)
        if chooser then chooser:delete() end
    end)

    -- The table of choices to present to the user. It's comprised of one empty
    -- item (which we update as the user types), and those passed in as options
    local choiceList = { {text=''} }
    for i=1, #options do
        choiceList[#choiceList+1] = {text=options[i]}
    end

    chooser:choices(function()
        choiceList[1]['text'] = chooser:query()
        return choiceList
    end)

    -- Re-compute the choices every time a key is pressed, to ensure that the top
    -- choice is always the entered text:
    chooser:queryChangedCallback(function() chooser:refreshChoicesCallback() end)

    chooser:show()
end

-- Read the last {count} lines of the log file, ordered with the most recent one first
Log.read = function(count)
    if not count then count = 10 end
    -- Note the funky sed command at the end is to reverse the ordering of the lines:
    return hs.execute('tail -' .. count .. ' ' .. LOG_FILE .. " | sed '1!G;h;$!d' ${inputfile}")
end

Log.writeItem = function(pomo)
    local timestamp = os.date('%Y-%m-%d %H:%M')
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

-- Return a table of recent task names, most recent first
Log.getRecentTaskNames = function()
    local tasks = Log.getLatestItems(10)
    local nonEmptyTasks = hs.fnutils.filter(tasks, function(t) return t ~= '' end)
    local names = hs.fnutils.map(nonEmptyTasks, function(taskWithTimestamp)
        local taskStartPosition = string.find(taskWithTimestamp, ']') + 2
        return string.sub(taskWithTimestamp, taskStartPosition)
    end)

    -- TODO: dedupe these items before returning
    return names
end

Commands.startNew = function()
    local options = Log.getRecentTaskNames()
    showChooserPrompt(options, function(taskName)
        if taskName then
            currentPomo = {minutesLeft=POMO_LENGTH, name=taskName}
        end
        App.updateUI()
    end)
end

Commands.togglePaused = function()
    if not currentPomo then return end
    currentPomo.paused = not currentPomo.paused
    App.updateUI()
end

Commands.toggleLatestDisplay = function()
    local logs = Log.read(15)
    local displayDuration = 500
    if alertId then
        hs.alert.closeSpecific(alertId)
        alertId = nil
    else
        alertId = hs.alert('LATEST ACTIVITY\n\n' .. logs, {textFont='Courier'}, displayDuration)
    end
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
        local n = hs.notify.new({
            title='Pomodoro complete',
            subTitle=currentPomo.name,
            informativeText='Completed at ' .. os.date('%H:%M'),
            soundName='Hero'
        })
        n:autoWithdraw(false)
        n:hasActionButton(false)
        n:send()
        App.complete(currentPomo)
    end
    App.updateUI()
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
