-- See :h mini.statusline
local statusline = require('mini.statusline')
statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
      local git = statusline.section_git({ trunc_width = 40 })
      local lsp = statusline.section_lsp({ trunc_width = 75 })
      local filename = statusline.section_filename({ trunc_width = 999 })
      local fileinfo = statusline.section_fileinfo({ trunc_width = 9999 })
      local search = statusline.section_searchcount({ trunc_width = 75 })
      local location = '%3l:%v' -- simple line/column without icon

      -- TODO: clean up highlighting
      return statusline.combine_groups({
        { hl = mode_hl, strings = { git } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment

        { hl = 'MiniStatuslineLocation', strings = { location } },
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo, lsp } },
        { hl = 'MiniHipatternsHack', strings = { search } },
      })
    end,
  },
})
