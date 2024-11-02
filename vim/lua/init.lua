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
local fuzzy = require('fuzzy')

require('statusline')
require('tabline')
require('searchscroll')
require('tree')

require('mini.bracketed').setup()
require('mini.pairs').setup()

require('mini.pick').setup(fuzzy.miniPickConfig)
require('mini.splitjoin').setup({ mappings = { toggle = '', split = 'gS', join = 'gJ' } })
require('mini.surround').setup()
