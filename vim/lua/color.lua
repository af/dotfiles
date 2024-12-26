-- Base16 color scheme
-- guide: https://github.com/chriskempson/base16/blob/main/styling.md
--
-- v1: maybe use colors from https://www.nordtheme.com/docs/colors-and-palettes

local palette = {
  base00 = '#00242E', -- default bg
  base01 = '#00242E', -- line number bg
  base02 = '#003959', -- statusline bg, selection bg
  base03 = '#62869C', -- line number fg, comments
  base04 = '#d5dc81',
  base05 = '#D9DBDC', -- default fg
  base06 = '#eff69c',
  base07 = '#fcffaa',
  base08 = '#00a5c5',
  base09 = '#E4CAA1',
  base0A = '#95D3FF', -- classes, Markup Bold, Search Text Background
  base0B = '#A4BF8E', -- strings
  base0C = '#00a5c5',
  base0D = '#86B9D0',
  base0E = '#86B9D0', -- keywords
  base0F = '#00a5c5',
}

require('mini.base16').setup({
  palette = palette,
  use_cterm = true,
})

vim.api.nvim_set_hl(0, 'MiniPickMatchCurrent', { bg = palette.base03, fg = '#ffffff' })

vim.api.nvim_set_hl(0, 'MiniDiffSignDelete', { fg = '#BF616A', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'MiniDiffSignChange', { fg = '#EBCB8B', bg = 'NONE' })
vim.api.nvim_set_hl(0, 'MiniDiffSignAdd', { fg = '#8FBC8B', bg = 'NONE' })

vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#BF616A', bg = 'NONE' })

-- syntax highlighting overrides:
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', { fg = palette.base03, bold = true })
vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = palette.base0D, bold = true })

-- highlight link DiagnosticSignError healthError
-- highlight link DiagnosticSignWarning SpecialChar
-- highlight link DiagnosticVirtualTextError healthError
