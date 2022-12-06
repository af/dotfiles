require('nvim-tree').setup({
  sort_by = 'case_sensitive',
  remove_keymaps = { 'H' },
  renderer = {
    group_empty = true,
    indent_width = 1,
  },
  filters = {
    dotfiles = false,
  },
  git = {
    ignore = false,
  },
})

-- netrw is disabled to help with the tree
-- The following mapping re-implements `gx` in normal mode
function _G.open_in_browser()
  local url = string.match(vim.fn.expand('<cWORD>'), 'https?://[%w-_%.%?%.:/%+=&]+[^ >"\',;`]*')
  if url ~= nil then
    if vim.fn.has('macunix') == 1 then
      vim.cmd(('!open "%s"'):format(url))
    else
      vim.cmd(('!xdg-open "%s"'):format(url))
    end
  else
    print('No https or http URI found in line.')
  end
end
vim.api.nvim_set_keymap('n', 'gx', '<cmd>lua open_in_browser()<cr>', {})
