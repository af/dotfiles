local vimCmd = vim.api.nvim_command

local API = {}

local defaultLocListHeight = 10

local getBufferCount = function()
  -- TODO: do more of this in lua instead of eval'ing everything
  return vim.api.nvim_eval("len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))")
end

-- Lua port of LListToggle from https://github.com/Valloric/ListToggle/blob/master/plugin/listtoggle.vim
API.toggleLocationList = function()
  local bufCountBefore = getBufferCount()

  -- Location list can't be closed if there's cursor in it, so we need
  -- to call lclose twice to move cursor to the main pane
  vimCmd('silent! lclose')
  vimCmd('silent! lclose')

  local wasJustClosed = getBufferCount() ~= bufCountBefore
  if not wasJustClosed then
    vimCmd('silent! lopen ' .. defaultLocListHeight)
  end
end

return API
