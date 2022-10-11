-- For general LSP config info, see
-- https://github.com/neovim/nvim-lspconfig

local lspconfig = require('lspconfig')

--Enable completion with nvim-cmp
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
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

  local runformatter = function()
    vim.lsp.buf.format({
      filter = function(_client)
          return _client.name == "efm"
      end,
      bufnr = bufnr,
    })
  end

  -- TODO: cleanup. See https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = runformatter
    })
  end
end

-- TypeScript/JS
lspconfig.tsserver.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use prettier for formatting instead
    client.server_capabilities.documentFormatting = false
  end
}

-- Formatting via efm
local luafmt = {
  -- Docs: https://github.com/Koihik/LuaFormatter
  -- Install with:
  -- luarocks install --server=https://luarocks.org/dev luaformatter
  formatCommand = "lua-format --indent-width=2 -i",
  formatStdin = true
}

local prettier = {
  formatCommand = "prettier --stdin-filepath ${INPUT}",
  formatStdin = true
}

local eslint = {
  lintCommand = "eslint_d -f ~/dotfiles/tooling/eslint-formatter-vim.js --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c:%t: %m"},
}

-- TODO: look at stylelint-lsp:
-- https://www.jihadwaspada.com/post/how-to-setup-stylelint-with-neovim-lsp/
local stylelint = {
  lintCommand = 'stylelint --stdin --stdin-filename ${INPUT} --formatter compact',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {
    '%f: line %l, col %c, %tarning - %m',
    '%f: line %l, col %c, %trror - %m',
  },
  formatCommand = 'stylelint --fix --stdin --stdin-filename ${INPUT}',
  formatStdin = true,
}

local pgformatter = {
  formatCommand = "pg_format ${INPUT}",
  formatStdin = true,
}

local languages = {
  graphql = {prettier},
  lua = {luafmt},
  typescript = {prettier, eslint},
  javascript = {prettier, eslint},
  typescriptreact = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  css = {stylelint},
  markdown = {prettier},
  sql = {pgformatter}
}

lspconfig.efm.setup {
  root_dir = lspconfig.util.root_pattern(".git/"),
  filetypes = vim.tbl_keys(languages),
  init_options = {documentFormatting = true, codeAction = true},
  on_attach=on_attach,
  settings = { languages = languages }
}

-- CSS
lspconfig.cssls.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use prettier for formatting instead
    client.server_capabilities.document_formatting = false
  end,
  filetypes={ "css", "scss", "stylus" }
}

-- JSON
lspconfig.jsonls.setup{
  capabilities = capabilities,
  on_attach=on_attach
}

-- Lua
-- Need to run `brew install lua-language-server` for support
lspconfig.sumneko_lua.setup{
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = {
        globals = {'vim', 'hs'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = { enable = false, },
    },
  }
}

-- VimScript
lspconfig.vimls.setup{
  on_attach=on_attach
}
