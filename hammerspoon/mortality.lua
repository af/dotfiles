-- mortality tracker
-- Puts the (estimated) number of days you have left in the menu bar
local HOUR = 3600

local init = function(estimatedDeath)
  local menu = hs.menubar.new()
  local textStyle = {font={name='Futura Condensed Medium', size=14}}
  local updateText = function()
    local now = os.time()
    local daysLeft = (estimatedDeath - now) / (HOUR * 24)
    local text = hs.styledtext.new('💀' .. math.floor(daysLeft), textStyle)
    menu:setTitle(text)
  end

  hs.timer.doEvery(12 * HOUR, updateText)
  updateText()
end

return init
