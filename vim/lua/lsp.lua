-- For general LSP config info, see
-- https://github.com/neovim/nvim-lspconfig

local lspconfig = require('lspconfig')

--Enable completion (see https://github.com/neovim/nvim-lspconfig/issues/490#issuecomment-753624074)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

-- Customize diagnostics display (ie virtual text)
-- via https://github.com/nvim-lua/diagnostic-nvim/issues/73#issue-737897078
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 4,
      prefix = '✗',
    },
  }
)

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gR', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<C-e>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[w', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']w', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<C-w>', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
end

-- TypeScript/JS
lspconfig.tsserver.setup{
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    -- use prettier for formatting instead
    client.resolved_capabilities.document_formatting = false
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
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
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

local languages = {
  lua = {luafmt},
  typescript = {prettier, eslint},
  javascript = {prettier, eslint},
  typescriptreact = {prettier, eslint},
  javascriptreact = {prettier, eslint},
  yaml = {prettier},
  json = {prettier},
  html = {prettier},
  css = {stylelint},
  markdown = {prettier}
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
    client.resolved_capabilities.document_formatting = false
  end,
  filetypes={ "css", "scss", "stylus" }
}

-- JSON
lspconfig.jsonls.setup{
  capabilities = capabilities,
  on_attach=on_attach
}

-- Lua
-- Extra one-time setup is required for this, until it hopefully gets added to homebrew
-- Follow https://github.com/sumneko/lua-language-server/issues/232
local lua_lsp_dir = '/usr/local/Cellar/lua-language-server/1.18.1'
local lua_lsp_bin = lua_lsp_dir .. '/bin/lua-langserver'
lspconfig.sumneko_lua.setup{
  cmd = {lua_lsp_bin, '-E', lua_lsp_dir .. '/main.lua'},
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      diagnostics = {
        globals = {'vim', 'hs'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
        },
      },
    },
  }
}

-- VimScript
lspconfig.vimls.setup{
  on_attach=on_attach
}
