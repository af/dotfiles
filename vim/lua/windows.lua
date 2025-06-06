local vimFn = vim.api.nvim_call_function
local vimCmd = vim.api.nvim_command
local math = require('math')

local M = {}

local defaultLocListHeight = 10

local getBufferCount = function()
  -- TODO: do more of this in lua instead of eval'ing everything
  return vim.api.nvim_eval("len(filter(range(1, bufnr('$')), 'bufwinnr(v:val) != -1'))")
end

-- Lua port of LListToggle from https://github.com/Valloric/ListToggle/blob/master/plugin/listtoggle.vim
M.toggleLocationList = function()
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

M.moveRight = function()
  if vim.api.nvim_buf_get_option(0, 'filetype') == 'nerdtree' then
    vimCmd('wincmd p')
  else
    vimCmd('wincmd l')
  end
end

-- Open 'alternate' file(s) in vsplits based on current file's path
-- eg. when editing foo.js, open sibling foo.css file in a vsplit
--
-- Uses some tricks from https://stackoverflow.com/questions/17170902/in-vim-how-to-switch-quickly-between-h-and-cpp-files-with-the-same-name
M.vsplitAlternateFiles = function()
  local thisFile = vimFn('expand', { '%' })
  if thisFile == '' then
    return
  end

  -- todo: clean up extension logic. Lua patterns don't support alternation :(
  local thisFileWithoutExt = vimFn('expand', { '%:r' })
  thisFileWithoutExt = thisFileWithoutExt
    :gsub('%_test$', '')
    :gsub('%.test$', '')
    :gsub('%.spec$', '')
    :gsub('%.module$', '')
  local siblingFiles = vimFn('glob', { thisFileWithoutExt .. '*' })
  local siblings = vim.split(siblingFiles, '\n')

  for _, filename in pairs(siblings) do
    if filename ~= thisFile then
      local bufferNumber = vimFn('bufnr', { filename })
      local fileNotOpenInWindow = vimFn('bufwinnr', { bufferNumber }) < 0
      if fileNotOpenInWindow then
        vim.api.nvim_command('vsplit ' .. filename)
      end
    end
  end
end

-- Open centered floating window for use with fzf
--
-- via https://gabrielpoca.com/2019-11-13-a-bit-more-lua-in-your-vim/
-- see also https://github.com/huytd/vim-config/blob/master/init.vim#L132-L171
M.openCenteredFloat = function()
  -- get the editor's max width and height
  local width = vim.api.nvim_get_option('columns')
  local height = vim.api.nvim_get_option('lines')

  -- create a new, scratch buffer, for fzf
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  local win_height = math.ceil(height * 0.85)

  -- width behaves slightly differently for small/large windows
  local win_width
  if width < 150 then
    win_width = math.ceil(width - 8)
  else
    -- use 90% of the editor's width
    win_width = math.ceil(width * 0.9)
  end

  vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = math.ceil((height - win_height) / 2),
    col = math.ceil((width - win_width) / 2),
    style = 'minimal',
  })
end

-- Global key bindings
vim.keymap.set('n', '<C-l>', M.moveRight)
vim.keymap.set('n', '<leader>a', M.vsplitAlternateFiles)
vim.keymap.set('n', '<leader>w', M.toggleLocationList)

return M
