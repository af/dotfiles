-- Open centered floating window for use with fzf
--
-- via https://gabrielpoca.com/2019-11-13-a-bit-more-lua-in-your-vim/
-- see also https://github.com/huytd/vim-config/blob/master/init.vim#L132-L171
function NavigationFloatingWin()
  -- get the editor's max width and height
  local width = vim.api.nvim_get_option('columns')
  local height = vim.api.nvim_get_option('lines')

  -- create a new, scratch buffer, for fzf
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')

  local win_height = math.ceil(height * 0.9)

  -- width behaves slightly differently for small/large windows
  local win_width
  if (width < 150) then
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


-- alias for readability/concision
local vimFn = vim.api.nvim_call_function

-- Open 'alternate' files in vsplits based on current file's path
-- eg. when editing foo.js, open sibling foo.css file in a vsplit
--
-- Uses some tricks from https://stackoverflow.com/questions/17170902/in-vim-how-to-switch-quickly-between-h-and-cpp-files-with-the-same-name
function VsplitAlternateFiles()
  local thisFile = vimFn('expand', {'%'})
  local thisFileWithoutExt = vimFn('expand', {'%:r'})
  local siblingFiles = vimFn('glob', {thisFileWithoutExt .. '.*'})
  local siblings = vim.split(siblingFiles, '\n')

  for k, filename in pairs(siblings) do
    if (filename ~= thisFile) then
      local bufferNumber = vimFn('bufnr', {filename})
      local fileNotOpenInWindow = vimFn('bufwinnr', {bufferNumber}) < 0
      if (fileNotOpenInWindow) then
        vim.api.nvim_command('vsplit ' .. filename)
      end
    end
  end
end
