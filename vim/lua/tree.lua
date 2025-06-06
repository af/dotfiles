local on_attach = function(bufnr)
  local api = require('nvim-tree.api')
  api.config.mappings.default_on_attach(bufnr)

  -- Remove nvim-tree's default H and M mappings (use nvim's defaults instead)
  vim.keymap.del('n', 'H', { buffer = bufnr })
  vim.keymap.del('n', 'M', { buffer = bufnr })
end

require('nvim-tree').setup({
  on_attach = on_attach,
  sort_by = 'case_sensitive',
  disable_netrw = true,
  renderer = {
    add_trailing = true,
    group_empty = true,
    indent_width = 1,
    highlight_opened_files = 'all',
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = false, -- had some performance problems with this integration
    ignore = false,
  },
  view = {
    width = 35,
  },
  update_focused_file = {
    enable = true,
    update_root = false,
  },

  -- fix for :q being slow in nvim-tree when there's a large node_modules dir
  -- see https://github.com/nvim-tree/nvim-tree.lua/issues/2438#issuecomment-1848866750
  filesystem_watchers = {
    enable = false,
    -- enable = true,
    debounce_delay = 50,
    ignore_dirs = {
      'node_modules',
    },
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
