-- For customization see https://github.com/akinsho/bufferline.nvim
require('bufferline').setup({
  options = {
    tab_size = 12;
    diagnostics = 'nvim_lsp';
    show_buffer_close_icons = false;
    separator_style = 'slant';

    -- Fancy colorful icons via kyazdani42/nvim-web-devicons
    color_icons = true;
    show_buffer_icons = true;

    -- Separate errors and warnings in tab diagnostics
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "✖ "
          or (e == "warning" and "⚠ " or "H " )
        s = s .. n .. sym
      end
      return s
    end
  },
})
