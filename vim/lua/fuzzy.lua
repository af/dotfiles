local utils = require('utils')
local vimFn = vim.api.nvim_call_function

local API = {}

local yellow = function(t)
  local color = "\x1B[33m"
  local reset = "\x1B[m"
  return color .. t .. reset
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
        table.insert(bufnames, yellow(localbufname))
      end
    end
  end

  table.insert(bufnames, currentFile)
  if (not utils.isEmpty(bufnames)) then
    utils.reverse(bufnames)
    -- separate buffers and project files with a single extra newline:
    table.insert(bufnames, '')
  end
  return table.concat(bufnames, '\n')
end

return API
