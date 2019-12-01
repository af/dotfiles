-- vim: ft=lua tw=80

-- luacheck linter config for neovim and hammerspoon configs
-- see https://luacheck.readthedocs.io/en/stable/config.html

files['vim/lua'] = {
   read_globals = {'vim', 'pairs'} -- these globals can only be accessed
}

files["hammerspoon"] = {
   globals = {'hs'}
}
