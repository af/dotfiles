require('mini.diff').setup({
  view = {
    style = 'sign',
    -- signs = { add = '▒', change = '▒', delete = '_' },
    signs = { add = '┃', change = '┃', delete = '_' },
  },

  mappings = {
    goto_prev = '[h',
    goto_next = ']h',
  },
})

-- reset (revert) the changes of the hunk the cursor is inside (if any)
vim.keymap.set('n', '<leader>hr', function()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local hunks = require('mini.diff').get_buf_data(0).hunks

  -- Find the hunk containing the current line and reset it
  for _, hunk in ipairs(hunks) do
    if current_line >= hunk.buf_start and current_line <= hunk.buf_start + hunk.buf_count - 1 then
      require('mini.diff').do_hunks(0, 'reset',
        { line_start = hunk.buf_start, line_end = hunk.buf_start + hunk.buf_count - 1 })
      return
    end
  end
end, { desc = 'Reset git hunk' })

-- Implement a 'Browse' command for vim-rhubarb's GBrowse to work
vim.api.nvim_create_user_command(
  'Browse',
  function(opts)
    vim.fn.system { 'open', opts.fargs[1] }
  end,
  { nargs = 1 }
)

-- visual mapping to get a GitHub URL for the visual selection
vim.keymap.set('v', 'gl', ':GBrowse<CR>', { desc = 'Open GitHub URL' })
