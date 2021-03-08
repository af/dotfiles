-- For config, see https://github.com/hoob3rt/lualine.nvim
local lualine = require('lualine')

local function filepath()
  local path = vim.fn.expand('%')
  if vim.fn.winwidth(0) <= 84 then
    path = vim.fn.pathshorten(path)
  end
  return path
end

lualine.options.theme = 'nord'

lualine.sections = {
  lualine_a = {},
  lualine_b = {'branch'},
  lualine_c = {filepath},
  -- WIP: diagnostics
  -- see https://github.com/hoob3rt/lualine.nvim/blob/master/lua/lualine/components/diagnostics.lua
  -- lualine_x = { { 'diagnostics', sources={ 'nvim_lsp' }, colored=true } },
  lualine_y = {'filetype'},
  lualine_z = {'location'},
}
lualine.inactive_sections = {
  lualine_a = {},
  lualine_b = {},
  lualine_c = {'filename'},
  lualine_x = {'location'},
  lualine_y = {},
  lualine_z = {}
}
lualine.status()
