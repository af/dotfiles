-- mortality tracker
-- Puts the (estimated) number of days you have left in the menu bar
local HOUR = 3600

local init = function(estimatedDeath)
  local menu = hs.menubar.new()
  local textStyle = {font={name='Futura Condensed Medium', size=14}}
  local updateText = function()
    local now = os.time()
    local daysLeft = (estimatedDeath - now) / (HOUR * 24)
    local roundedDays = math.floor(daysLeft * 10) / 10  -- Show one decimal point
    local text = hs.styledtext.new('💀' .. roundedDays, textStyle)
    menu:setTitle(text)
  end

  hs.timer.doEvery(HOUR, updateText)
  updateText()
end

return init
