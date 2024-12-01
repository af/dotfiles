local M = {}
local MiniPick = require('mini.pick')

local picker_win_config = function()
  return {
    anchor = 'SW',
    relative = 'editor',
    height = math.floor(0.618 * vim.o.lines),
    width = vim.o.columns,
  }
end

M.miniPickConfig = {
  mappings = {
    move_down = '<C-j>',
    move_up = '<C-k>',
  },
  window = { config = picker_win_config },
}

MiniPick.setup(M.miniPickConfig)

M.openFilePickOnOpen = function()
  -- if a file was read on open, don't launch the picker
  local currentBufName = vim.api.nvim_buf_get_name(0)
  if currentBufName ~= '' then
    return
  end

  M.customPicker()

  -- for some reason, need to manually set filetype here, it's not set automatically when calling
  -- the picker on VimEnter (??)
  vim.cmd('filetype detect')
end

-- Custom picker (like MiniPick.builtin.files()), but sorts files by access time
-- see https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/pick.lua
M.customPicker = function()
  -- copied from minipick source
  local show_with_icons = function(buf_id, items, query)
    MiniPick.default_show(buf_id, items, query, { show_icons = true })
  end

  local sortedCmd = { 'rg', '--files', '--no-follow', '--color=never', '--sortr=accessed' }
  MiniPick.builtin.cli(
    { command = sortedCmd },
    { source = { name = '  ', show = show_with_icons } }
  )
end

return M
