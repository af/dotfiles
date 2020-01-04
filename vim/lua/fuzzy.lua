local utils = require('utils')
local vimFn = vim.api.nvim_call_function

local API = {}

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
        table.insert(bufnames, localbufname)
      end
    end
  end

  if (not utils.isEmpty(bufnames)) then
    utils.reverse(bufnames)
    table.insert(bufnames, '\n---\n')
  end
  return table.concat(bufnames, '\n')
end

return API
