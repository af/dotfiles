-- must be before lspconfig setup
require('neodev').setup()

-- For general LSP config info, see
-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')

-- Enable completion with nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
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
  buf_set_keymap('n', '[w', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']w', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<C-w>', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)

  _G.runformatter = function()
    vim.lsp.buf.format({
      filter = function(_client)
        return _client.name == 'null-ls'
      end,
      bufnr = bufnr,
    })
  end

  -- TODO: cleanup. See https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
  -- buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua _G.runformatter()<CR>', opts)

  -- FIXME: this should work for null-ls also!
  -- if client.supports_method("textDocument/formatting") then
  vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  vim.api.nvim_create_autocmd(
    'BufWritePre',
    { group = augroup, buffer = bufnr, callback = _G.runformatter }
  )
  -- end
end

-- Set up integrations with non-LSP tools
-- See https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require('null-ls')
null_ls.setup({
  on_attach = on_attach,
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.pg_format,

    -- Docs: https://github.com/JohnnyMorganz/StyLua
    -- Install with: npm i -g @johnnymorganz/stylua-bin
    null_ls.builtins.formatting.stylua, -- eslint actions & diagnostics
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.diagnostics.eslint,

    -- stylelint formatting & diagnostics
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.formatting.stylelint,
  },
})

-- TypeScript/JS
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use prettier for formatting instead
    client.server_capabilities.documentFormatting = false
  end,
})

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use prettier for formatting instead
    client.server_capabilities.document_formatting = false
  end,
  filetypes = { 'css', 'scss', 'stylus' },
})

-- JSON
lspconfig.jsonls.setup({ capabilities = capabilities, on_attach = on_attach })

-- Lua
-- Need to run `brew install lua-language-server` for support
lspconfig.sumneko_lua.setup({
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

-- VimScript
lspconfig.vimls.setup({ on_attach = on_attach })
