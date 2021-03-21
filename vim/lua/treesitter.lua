require('nvim-treesitter.configs').setup {
  ensure_installed = {'typescript', 'javascript', 'css', 'html', 'json', 'yaml'},
  indent = {enable = true},
  highlight = {enable = true}
}

