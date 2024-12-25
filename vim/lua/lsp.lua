-- must be before lspconfig setup
require('neodev').setup()

-- For general LSP config info, see
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')

-- Enable completion with nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Format on save
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-e>', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', '<C-w>', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
end

lspconfig.biome.setup({})
lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })
lspconfig.graphql.setup({})
lspconfig.vimls.setup({ on_attach = on_attach })

-- TypeScript/JS
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use biome for formatting instead
    client.server_capabilities.documentFormatting = false
  end,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use biome for formatting instead
    client.server_capabilities.document_formatting = false
  end,
  filetypes = { 'css', 'scss', 'stylus' },
})

-- Lua
-- Need to run `brew install lua-language-server` for support
lspconfig.lua_ls.setup({
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
