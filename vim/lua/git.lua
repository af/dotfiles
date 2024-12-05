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

vim.api.nvim_set_keymap(
  'n',
  'gl',
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true }
)
vim.api.nvim_set_keymap(
  'v',
  'gl',
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  {}
)
