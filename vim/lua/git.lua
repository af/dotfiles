require('mini.diff').setup({
  view = {
    style = 'sign',
    -- signs = { add = '▒', change = '▒', delete = '_' },
    signs = { add = '┃', change = '┃', delete = '_' },
  },

  mappings = {
    -- TODO: port this mapping over (gh is the default mapping, but need visual mode?)
    -- reset = '<leader>hr',
    goto_prev = '[h',
    goto_next = ']h',
  },
})

-- Implement a 'Browse' command for vim-rhubarb's GBrowse to work
vim.api.nvim_create_user_command(
  'Browse',
  function(opts)
    vim.fn.system { 'open', opts.fargs[1] }
  end,
  { nargs = 1 }
)
