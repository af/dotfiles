-- Completion settings for nvim-compe
-- For docs, see :h compe
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'always';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;  -- Neat, but seems a bit flaky
    nvim_lsp = true;
    nvim_lua = true;
    omni = false;  -- This gets really noisy
    snippets_nvim = false;
    treesitter = false;
  };
}
