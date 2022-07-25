require('nvim-treesitter.configs').setup {
  ensure_installed = {'typescript', 'javascript', 'css', 'html', 'json', 'yaml', 'graphql', 'lua', 'rust', 'toml', 'markdown', 'python', 'sql', 'bash'},
  indent = {enable = true},
  highlight = {enable = true},

  -- Incremental selection with <CR>! via:
  -- https://www.reddit.com/r/neovim/comments/r10llx/the_most_amazing_builtin_feature_nobody_ever/
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      -- scope_incremental = '<TAB>',
    }
  }
}

