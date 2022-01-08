-- setup for scrollbar and search highlighting
-- see https://github.com/petertriho/nvim-scrollbar

require('hlslens').setup({
  build_position_cb = function(plist)
    require('scrollbar.handlers.search').handler.show(plist.start_pos)
  end
})

require('scrollbar').setup({
  -- TODO: don't hardcode this color value
  handle = {color = '#445588'},
  excluded_filetypes = {'', 'prompt', 'nerdtree'}
})

vim.cmd([[
  augroup scrollbar_search_hide
    autocmd!
    autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
  augroup END
]])
