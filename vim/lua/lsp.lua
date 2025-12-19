-- must be before lspconfig setup
require('neodev').setup()

-- For general LSP config info, see
-- https://github.com/neovim/nvim-lspconfig
--
-- Attempting to stick to the default keymappings (see :h lsp-defaults):
-- grn    -> rename symbol
-- grr    -> list references
-- grt    -> go to type definition
-- gd     -> go to local definition
-- <C-]>  -> go to global definition

-- Enable completion with nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

vim.lsp.enable('biome')
vim.lsp.enable('graphql')
vim.lsp.enable('vimls')
-- vim.lsp.enable('jsonls')

-- TypeScript/JS
vim.lsp.config('ts_ls', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- use biome for formatting instead
    client.server_capabilities.documentFormatting = false
  end,
})
vim.lsp.enable('ts_ls')

-- CSS
vim.lsp.config('cssls', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- use biome for formatting instead
    client.server_capabilities.document_formatting = false
  end,
  filetypes = { 'css', 'scss' },
})
vim.lsp.enable('cssls')

-- Lua
-- Need to run `brew install lua-language-server` for support
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = { globals = { 'vim', 'hs' } },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.enable('lua_ls')

-- ruby
vim.lsp.config('rubocop', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.document_formatting = true
  end
})
vim.lsp.config('ruby_lsp', { capabilities = capabilities })

-- python
vim.lsp.config('ty', {
  capabilities = capabilities,
  root_markers = { 'uv.lock' },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
        -- diagnosticMode = "workspace",
      },
    },
  },
})
vim.lsp.enable('ty')
vim.lsp.enable('ruff')
