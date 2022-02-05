-- setup for scrollbar and search highlighting
-- see https://github.com/petertriho/nvim-scrollbar

require('scrollbar').setup({
  -- TODO: don't hardcode this color value
  handle = {color = '#445588'},
  excluded_filetypes = {'', 'prompt', 'nerdtree'}
})
