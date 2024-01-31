vim.g.barbar_auto_setup = false -- disable auto-setup

-- see https://github.com/romgrk/barbar.nvim
require('barbar').setup({
  -- fixme: better diagnostics bg color
  icons = {
    button = '',
    diagnostics = {
      [vim.diagnostic.severity.ERROR] = { enabled = true, icon = '✖ ' },
      [vim.diagnostic.severity.WARN] = { enabled = true, icon = '⚠ ' },
      [vim.diagnostic.severity.INFO] = { enabled = false },
      [vim.diagnostic.severity.HINT] = { enabled = true },
    },
    separator = { left = '', right = '' },
  },
})
