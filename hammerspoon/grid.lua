ext = {}
ext.grid = {}
ext.grid.BORDER = 1

-- Describe the share of the screen that the L/R "chunks" take:
ext.grid.L_CHUNK_SHARE = 0.6
ext.grid.R_CHUNK_SHARE = 0.4

function ext.grid.fullscreen()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  win:setFrame(screenframe)
end

function ext.grid.lefthalf()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x,
    y = screenframe.y,
    w = screenframe.w / 2 - ext.grid.BORDER,
    h = screenframe.h,
  }

  win:setFrame(newframe)
end

function ext.grid.righthalf()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x + screenframe.w / 2 + ext.grid.BORDER,
    y = screenframe.y,
    w = screenframe.w / 2 - ext.grid.BORDER,
    h = screenframe.h,
  }

  win:setFrame(newframe)
end

function ext.grid.topleft()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x,
    y = screenframe.y,
    w = screenframe.w * ext.grid.L_CHUNK_SHARE - ext.grid.BORDER,
    h = screenframe.h / 2 - ext.grid.BORDER,
  }

  win:setFrame(newframe)
end

function ext.grid.bottomleft()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x,
    y = screenframe.y + screenframe.h / 2 + ext.grid.BORDER,
    w = screenframe.w * ext.grid.L_CHUNK_SHARE - ext.grid.BORDER,
    h = screenframe.h / 2 - ext.grid.BORDER,
  }

  win:setFrame(newframe)
end

function ext.grid.topright()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x + screenframe.w * ext.grid.L_CHUNK_SHARE + ext.grid.BORDER,
    y = screenframe.y,
    w = screenframe.w * ext.grid.R_CHUNK_SHARE - ext.grid.BORDER,
    h = screenframe.h / 2 - ext.grid.BORDER,
  }

  win:setFrame(newframe)
end

function ext.grid.bottomright()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x + screenframe.w * ext.grid.L_CHUNK_SHARE + ext.grid.BORDER,
    y = screenframe.y + screenframe.h / 2 + ext.grid.BORDER,
    w = screenframe.w * ext.grid.R_CHUNK_SHARE - ext.grid.BORDER,
    h = screenframe.h / 2 - ext.grid.BORDER,
  }

  win:setFrame(newframe)
end

function ext.grid.pushwindow()
  local win = hs.window.focusedWindow()
  if not win then return end

  local winframe = win:frame()
  local nextscreen = win:screen():next()
  local screenframe = nextscreen:frame_without_dock_or_menu()
  local newframe = {
    x = screenframe.x,
    y = screenframe.y,
    w = winframe.w,
    h = winframe.h,
  }

  win:setFrame(newframe)
end

function ext.grid.screenframe(win)
  return win:screen():frame()
end



-- Customized versions of lefthalf() and righthalf() that make the left side slightly wider:
function ext.grid.leftchunk()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x,
    y = screenframe.y,
    w = screenframe.w * ext.grid.L_CHUNK_SHARE - ext.grid.BORDER,
    h = screenframe.h,
  }

  win:setFrame(newframe)
end

function ext.grid.rightchunk()
  local win = hs.window.focusedWindow()
  if not win then return end

  local screenframe = ext.grid.screenframe(win)
  local newframe = {
    x = screenframe.x + screenframe.w * ext.grid.L_CHUNK_SHARE + ext.grid.BORDER,
    y = screenframe.y,
    w = screenframe.w * ext.grid.R_CHUNK_SHARE - ext.grid.BORDER,
    h = screenframe.h,
  }

  win:setFrame(newframe)
end
