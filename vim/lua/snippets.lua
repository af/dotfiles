-- https://github.com/dcampos/nvim-snippy
require('snippy').setup({
  mappings = {
    is = {
      ['<Tab>'] = 'expand_or_advance',
      ['<S-Tab>'] = 'previous',
    },
    nx = {
      ['<leader>x'] = 'cut_text',
    },
  },
  scopes = {
    typescript = { '_', 'typescript', 'javascript' },
    typescriptreact = { '_', 'typescript', 'javascript' },
  },
})
