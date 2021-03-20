local fn = vim.fn
local gl = require('galaxyline')
local section = gl.section
gl.short_line_list = {'nerdtree'}

local colors = {
  bg = '#2E3440',
  fg = '#ffffff',
  line_bg = 'NONE',
  yellow = '#EBCB8B',
  cyan = '#A3BE8C',
  green = '#8FBCBB',
  gray = '#616E88',
  blue = '#5E81AC',
  red = '#BF616A'
}

local buffer_not_empty = function()
  if fn.empty(fn.expand('%:t')) ~= 1 then return true end
  return false
end

local padded = function(input)
  local startSpacer = function() return '  ' end
  local endSpacer = function() return ' ' end
  input.provider = { startSpacer, input.provider, endSpacer }
  return input
end

section.left = {
  {
    GitBranch = padded({
      provider = 'GitBranch',
      condition = require('galaxyline.provider_vcs').check_git_workspace,
      highlight = {colors.fg, colors.gray},
      separator = ' ',
      separator_highlight = {colors.bg, colors.bg}
    })
  }, {
    DiagnosticError = {
      provider = 'DiagnosticError',
      separator = ' ',
      icon = ' ✗ ',
      highlight = {colors.fg, colors.red},
      separator_highlight = {colors.bg, colors.bg}
    }
  }, {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = ' ⚠ ',
      separator = ' ',
      highlight = {colors.bg, colors.yellow},
      separator_highlight = {colors.bg, colors.bg}
    }
  }, {
    FileName = {
      provider = function() return fn.expand('%:F') end,
      condition = buffer_not_empty,
      separator = '',
      separator_highlight = {colors.green, colors.bg},
      highlight = {colors.green, colors.line_bg}
    }
  }
}

section.right = {
  {
    DiffAdd = {
      provider = 'DiffAdd',
      icon = '+',
      highlight = {colors.green, colors.line_bg}
    }
  }, {
    DiffModified = {
      provider = 'DiffModified',
      icon = '~',
      highlight = {colors.yellow, colors.line_bg}
    }
  }, {
    DiffRemove = {
      provider = 'DiffRemove',
      icon = '-',
      highlight = {colors.red, colors.line_bg}
    }
  }, {
    FileTypeName = padded({
      provider = 'FileTypeName',
      highlight = {colors.fg, colors.bg},
    })
  }, {
    LineInfo = padded({
      provider = 'LineColumn',
      highlight = {colors.bg, colors.green}
    })
  }
}
