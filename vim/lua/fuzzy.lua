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

  MiniPick.builtin.files()
end

M.openFilePickOnKeydown = function()
  -- see https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/pick.lua#L1280
  local command = { 'rg', '--files', '--no-follow', '--color=never' }
  local postprocess = function(t1)
    local bufs = vim.api.nvim_list_bufs()
    local bufNames = {}
    for _, buf in ipairs(bufs) do
      table.insert(bufNames, vim.api.nvim_buf_get_name(buf))
    end

    -- create new output table with bufNames at the beginning
    local result = {}
    table.move(bufNames, 1, #bufNames, 1, result)
    table.move(t1, 1, #t1, #bufNames + 1, result)
    return result
  end
  MiniPick.builtin.cli({ command = command, postprocess = postprocess }, opts)

  -- MiniPick.builtin.files({ })
end

-- TODO: migrate MRU picker from vim config:
-- " Custom MRU based on this example: https://github.com/junegunn/fzf/wiki/Examples-(vim)
-- command! FZFMru call fzf#run(fzf#wrap({
-- \ 'source':  filter(copy(v:oldfiles), "v:val !~ 'term:\\|fugitive:\\|NERD_tree_\\|__CtrlSF\\|^/tmp/\\|.git/'")
-- \ }))
-- nnoremap gm :FZFMru<CR>

return M
