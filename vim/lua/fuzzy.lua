local utils = require('utils')
local vimFn = vim.api.nvim_call_function

local API = {}

local yellow = function(t)
  local color = "\x1B[33m"
  local reset = "\x1B[m"
  return color .. t .. reset
end

local highlightName = function(path)
  -- wrap the last segment of a file path in ANSI color codes
  local highlighted = string.gsub(path, '[^/]+$', yellow)
  return highlighted
end

API.getBufferNames = function()
  local cwd = vimFn('getcwd', {})
  local bufs = vimFn('getbufinfo', {})
  local currentFile = vimFn('expand', {'%'})
  --print(vim.inspect(bufs))

  local bufnames = {}
  for _, buf in ipairs(bufs) do
    if (buf.name ~= '' and string.match(buf.name, 'NERD_tree_') == nil) then
      local localbufname, _ = string.gsub(buf.name, cwd .. '/', '')
      if (buf.listed == 1 and localbufname ~= currentFile) then
        table.insert(bufnames, highlightName(localbufname))
      end
    end
  end

  table.insert(bufnames, highlightName(currentFile))
  if (not utils.isEmpty(bufnames)) then
    utils.reverse(bufnames)
    -- separate buffers and project files with a single extra newline:
    table.insert(bufnames, '')
  end
  return table.concat(bufnames, '\n')
end

return API
