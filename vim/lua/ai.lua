require('supermaven-nvim').setup({
  keymaps = {
    accept_suggestion = '<C-p>',
    clear_suggestion = '<C-]>',
    -- accept_word = '<C-j>',
  },
  -- color = {
  --   suggestion_color = '#ffffff',
  --   cterm = 244,
  -- },
  disable_inline_completion = false, -- disables inline completion for use with cmp
  disable_keymaps = false, -- disables built in keymaps for more manual control
})
