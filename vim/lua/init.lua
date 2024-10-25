-- Main entrypoint for lua config

-- TODO: try/catch these imports to handle initial install run?
require('git')
require('treesitter')
require('lsp')
require('diagnostics')
require('nvim-highlight-colors').setup({ render = 'virtual', virtual_symbol = '■' })
require('snippets')
require('ai')
require('completion')
require('fuzzy')
require('windows')

require('statusline')
require('tabline')
require('searchscroll')
require('tree')

require('mini.pairs').setup()
