-- alias for readability/concision
local vimFn = vim.api.nvim_call_function
local vimCmd = vim.api.nvim_command

local API = {}

local _getFiletype = function()
  return vim.api.nvim_buf_get_option(0, 'filetype')
end

local _isNerdTreeOpen = function()
  local varExists = vimFn('exists', {'t:NERDTreeBufName'})
  if (varExists == 1) then
    local treeBufName = vim.api.nvim_tabpage_get_var(0, 'NERDTreeBufName')
    return vimFn('bufwinnr', {treeBufName}) ~= -1
  else
    return false
  end
end

-- go to the next window, but skip over nerdtree
API.toNextWindow = function()
  vimCmd('wincmd w')
  if (_getFiletype() == 'nerdtree') then
    vimCmd('wincmd w')
  end
end

-- Open Nerdtree to the current file
API.open = function()
  if _isNerdTreeOpen() then
    vimCmd('NERDTreeFind')
  else
    vimCmd('NERDTree %')
  end
end

API.unloadFile = function()
  local filetype = _getFiletype()
  if (filetype == 'ctrlsf' or filetype == 'nerdtree') then
    vimCmd('bdelete')
  elseif _isNerdTreeOpen() then
    local buffer_number = vimFn('bufnr', {'%'})
    vimCmd('bnext')
    vimCmd('bdelete ' .. buffer_number)
  else
    vimCmd('bdelete')
  end
end

return API
