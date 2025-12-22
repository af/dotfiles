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

local enable = function(lspname, config)
  if config then
    vim.lsp.config(lspname, config)
  end
  vim.lsp.enable(lspname)
end

enable('biome')
enable('graphql')
enable('vimls')
enable('jsonls')

-- TypeScript/JS
enable('ts_ls', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- use biome for formatting instead
    client.server_capabilities.documentFormatting = false
  end,
})

-- CSS
enable('cssls', {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    -- use biome for formatting instead
    client.server_capabilities.document_formatting = false
  end,
  filetypes = { 'css', 'scss' },
})

-- Lua
-- Need to run `brew install lua-language-server` for support
enable('lua_ls', {
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

-- ruby
enable('rubocop', {
  capabilities = capabilities,
  on_attach = function(client)
    client.server_capabilities.document_formatting = true
  end
})
enable('ruby_lsp', { capabilities = capabilities })

-- python
enable('ty', {
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
enable('ruff')
