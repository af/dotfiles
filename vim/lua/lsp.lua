-- For config info, see
-- https://github.com/neovim/nvim-lsp

-- TypeScript/JS
require'nvim_lsp'.tsserver.setup{}

-- CSS
require'nvim_lsp'.cssls.setup{
  filetypes = { "css", "scss", "less", "stylus" }
}

-- JSON
require'nvim_lsp'.jsonls.setup{}

-- Lua
-- Extra one-time setup is required for this
-- See https://github.com/neovim/nvim-lsp#sumneko_lua
-- require'nvim_lsp'.sumneko_lua.setup{}

-- VimScript
require'nvim_lsp'.vimls.setup{}
