-- Main entrypoint for lua config

-- TODO: try/catch these imports to handle initial install run?
require('git')
require('treesitter')
require('lsp')
require('diagnostics')
require('snippets')
require('ai')
require('completion')
require('windows')
require('highlight')

require('mini.git').setup() -- needed for statusline
require('statusline')
require('tabline')
require('tree')

require('mini.bracketed').setup()
require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.surround').setup()

require('mini.splitjoin').setup({ mappings = { toggle = '', split = 'gS', join = 'gJ' } })

local fuzzy = require('fuzzy')
vim.api.nvim_create_autocmd('VimEnter', { callback = fuzzy.openFilePickOnOpen })
vim.keymap.set('n', ',', fuzzy.customPicker)

vim.keymap.set('n', '<C-u>', function()
  require('mini.bufremove').delete(0, false)
end)

-- workalike for nvim-scrollbar
local map = require('mini.map')
map.setup({
  integrations = {
    map.gen_integration.builtin_search(),
  },
  window = {
    width = 1,
    winblend = 25,
  },
  symbols = {
    scroll_view = '█',
    scroll_line = '',
  },
})
map.open()
