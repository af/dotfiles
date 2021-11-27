-- customize diagnostics display. See:
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = '✗',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})

local signs = { Error = "✗ ", Warn = "⚠ ", Hint = "H ", Info = "I " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
