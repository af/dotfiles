set encoding=utf-8
scriptencoding utf-8

augroup vimrc
  autocmd!
augroup END

" General Notes
" * see ":h normal-index" or ":h insert-index" for a list of built-in mappings
" * see ":verbose nmap <C-j>" (for example) for maps setup by plugins or .vimrc
" * profile startup time with "vim --startuptime startup.log"
"
" Reminder (since this file now has folds): zR to open all folds in a file, zM to close them all
" zO to open recursively from cursor, zA to toggle recursively
" See :help fold-manual

" {{{ Plugin setup via vim-plug
" ==============================================================================
" * Run :PlugInstall to install
" * Run :PlugUpdate to update
"
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'dyng/ctrlsf.vim',             { 'commit': 'bf3611c' }
Plug 'junegunn/fzf',                { 'tag': '0.20.0', 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',            { 'commit': '467c327' }
Plug 'scrooloose/nerdtree',         { 'tag': '6.2.0', 'on': 'NERDTreeToggle' }
Plug 'PhilRunninger/nerdtree-buffer-ops', { 'commit': 'f5e77b8', 'on': 'NERDTreeToggle' }

Plug 'nvim-lua/plenary.nvim'  " Required for gitsigns
Plug 'lewis6991/gitsigns.nvim',     { 'commit': '521e935' }
Plug 'neovim/nvim-lspconfig',       { 'commit': '8435587' }
Plug 'hrsh7th/nvim-compe',          { 'commit': '077329e' }
Plug 'cohama/lexima.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'norcalli/snippets.nvim'
Plug 'glepnir/galaxyline.nvim' ,    { 'commit': 'd544cb9' }
Plug 'nvim-treesitter/nvim-treesitter', { 'commit': '4eb19c9', 'do': ':TSUpdate'}

" tpope appreciation section
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-commentary',        { 'commit': 'f8238d7' }
Plug 'tpope/vim-obsession',         { 'commit': '4ab72e0' }     " start a session file with :Obsession
Plug 'tpope/vim-surround',          { 'commit': '42e9b46' }
Plug 'tpope/vim-unimpaired',        { 'commit': '11dc568' }
Plug 'tpope/vim-fugitive',          { 'commit': '06e3420' }
Plug 'tpope/vim-rhubarb',           { 'commit': '9edacf9' }
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }

" Yanking and clipboard
Plug 'bfredl/nvim-miniyank',        { 'commit': '2a3a0f3' }

" Editing modifications
Plug 'AndrewRadev/splitjoin.vim',   { 'commit': '03af68c' }     " gS and gJ to split/join lines

" Indentation, etc. Autodetect, but override with .editorconfig if present:
" Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' }   " TODO: load lazily, w/o input lag

" language-specific plugins
Plug '~/dotfiles/vim/vendored/nerdtree_menu_terminal'
Plug 'junegunn/vim-xmark',          { 'commit': '6dd673a', 'do': 'make', 'for': 'markdown' }

" Color/Theme/syntax related plugins
Plug 'christianchiarulli/nvcode-color-schemes.vim'

" Misc
Plug 'vimwiki/vimwiki',             { 'commit': '417490f' }
Plug 'danro/rename.vim',            { 'commit': 'f133763' }

" Enabled periodically, but not by default:
" Plug 'takac/vim-hardtime',          { 'commit': 'acf59c8' }
" Plug 'troydm/zoomwintab.vim',       { 'commit': 'b7a940e' }

call plug#end()

" }}}
" {{{ General Vim settings
" ==============================================================================

let g:mapleader = ' '         " <leader> is our personal modifier key
set visualbell
set history=500             " longer command history (default=20)
set backspace=indent,eol,start
set noswapfile              " Disable swap files
set backupcopy=yes
set lazyredraw              " Speeds up macros by avoiding excessive redraws

" File/buffer settings
set hidden                  " Hides buffers instead of unloading them
set autoread                " reload files on changes (ie. changing git branches)
set scrolloff=3             " # of lines always shown above/below the cursor

" Indenting & white space
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent
set breakindent
set showbreak=…
set list listchars=tab:›\ ,trail:·          " mark trailing white space

" Speeds up startup time
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python'

" }}}
" {{{ Display/window settings
"===============================================================================
syntax on
set number                  " line number gutter
set ruler                   " line numbers at bottom of page
set showcmd
set title
set wildmenu
set wildignore=.svn,.git,.gitignore,*.pyc,*.so,*.swp,*.jpg,*.png,*.gif,node_modules,_site,_build,esy.lock
set laststatus=2            " Always show a status line for lowest window in a split
set cursorline              " highlight the full line that the cursor is currently on
set colorcolumn=80,100      " Highlight these columns with a different bg
set signcolumn=yes          " Always show sign column. Prevents rendering jank on startup
set showtabline=2
set splitright
set splitbelow
set shortmess+=c

" }}}
" {{{ Searching & Replacing
"===============================================================================
set ignorecase
set smartcase               " override 'ignorecase' if search term has upper case chars
set incsearch               " incremental search
set showmatch
set hlsearch                " highlight searched items
set gdefault                " use 'global' mode by default for substitutions

" Clear search highlighting with ' ,', use python-style search regexes:
nnoremap <leader>, :noh<cr>
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v

" }}}
" {{{ Line wrapping
"===============================================================================
set wrap
augroup quickfix
  autocmd!
  autocmd FileType qf setlocal nowrap
augroup END
set textwidth=99
autocmd vimrc FileType markdown,txt set breakindent
set formatoptions=qrn1j
nnoremap j gj
nnoremap k gk

" }}}
" {{{ Neovim-specific settings
"===============================================================================
if has('nvim')
  autocmd TermOpen * startinsert
  set termguicolors
  set inccommand=split
  set pumblend=5
  set winblend=7

  " See https://github.com/neovim/neovim/wiki/FAQ
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

  tnoremap <esc> <c-\><c-n>
  autocmd vimrc WinEnter term://* call feedkeys('i')

  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 1000)
  augroup END

  " TODO: try/catch these imports to handle initial install run?
  lua require('gitsigns').setup()
  lua require('colorizer').setup({ 'css'; 'stylus'; 'html'; })
  " TODO: try making a custom "inserter". See https://github.com/norcalli/snippets.nvim/issues/26
  lua require('snippets').set_ux(require'snippets.inserters.text_markers')
  lua snippets = require('mysnips')
  lua treesitter = require('treesitter')
  lua lsp = require('lsp')
  lua complete = require('completion')
  lua fuzzy = require('fuzzy')
  lua nerdtree = require('nerdtree')
  lua windows = require('windows')
  lua require('statusline')
elseif $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color'
  set t_Co=256    " 256 colours for regular vim if the terminal can handle it.
  let g:nvcode_termcolors=256
endif

" }}}
" {{{ Colorscheme & syntax
"===============================================================================
color nord
let g:nord_underline = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_uniform_diff_background = 1
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_italic = 1
set background=dark
set synmaxcol=400    " Performance improvement on large single-line files

" highlight trailing whitespace
augroup ErrorHighlights
  autocmd!
  autocmd InsertEnter * call clearmatches()
  autocmd InsertLeave * call matchadd('ErrorMsg', '\s\+$', 100)
augroup END

" syntax highlighting overrides:
highlight link NERDTreeOpenBuffer SpecialChar
highlight link ctrlsfFilename Keyword
highlight link GitSignsAdd GitGutterAdd
highlight link GitSignsDelete GitGutterDelete
highlight link GitSignsChange GitGutterChange

" Show syntax highlighting groups for word under cursor with <leader>S
" From Vimcasts #25: http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader>S :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" }}}
" {{{ LSP (WIP)
"===============================================================================

sign define LspDiagnosticsSignError text=✗ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=⚠ texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=I texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=H texthl=LspDiagnosticsSignHint linehl= numhl=
highlight link LspDiagnosticsSignError healthError
highlight link LspDiagnosticsSignWarning SpecialChar
highlight link LspDiagnosticsVirtualTextError healthError

" completion with nvim-compe
set completeopt=menuone,noselect

imap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <Tab>     compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" snippets
inoremap <C-j> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
inoremap <C-k> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

" }}}
" {{{ grepping (:grep, CTRLSF.vim, etc)
"===============================================================================

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Automatically open quickfix after executing a quickfix command (eg :grep)
augroup vimrc
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
augroup END

" CtrlSF.vim
let g:ctrlsf_ackprg = 'rg'
let g:ctrlsf_context = '-B 2 -A 2'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '65%'
let g:ctrlsf_indent = 1
let g:ctrlsf_ignore_dir = ['node_modules', '.git']
nnoremap <C-g> :CtrlSF ""<left>
nmap gr <Plug>CtrlSFCCwordExec
let g:ctrlsf_mapping = {
  \'chgmode' : '<A-m',
  \'open'    : '<CR>',
  \'openb'   : ['o', 'O'],
  \'split'   : '<C-s>',
  \'vsplit'  : '<C-v>',
  \'tab'     : '<C-t>',
  \'tabb'    : 't',
  \'popen'   : 'p',
  \'quit'    : 'q',
  \'next'    : '<C-J>',
  \'prev'    : '<C-K>',
  \'pquit'   : 'q',
  \'loclist' : '' }
let g:ctrlsf_auto_focus = {"at": "start"}

" }}}
" {{{ nerdtree
"===============================================================================

nnoremap - :lua nerdtree.open()<CR>
nnoremap <silent> <C-u> :lua nerdtree.unloadFile()<CR>

let NERDTreeMapOpenSplit = '<C-s>'
let NERDTreeMapOpenVSplit = '<C-v>'
let NERDTreeMapOpenInTab = '<C-t>'
let NERDTreeMapUpdirKeepOpen = '-'
let NERDTreeMapHelp = '<F1>'
let NERDTreeRespectWildIgnore=1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
autocmd vimrc FileType nerdtree nmap <buffer> % ma

" }}}
" {{{ More plugin customization
"===============================================================================

" FZF
" More tips: https://github.com/junegunn/fzf/wiki/Examples-(vim)
nnoremap <leader>H :History:<CR>
function! s:close_fzf_noop(files)
endfunction
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vertical split',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-u': 'bd',
  \ ',': function('s:close_fzf_noop')
  \ }
let $FZF_DEFAULT_OPTS='--layout=reverse --color gutter:-1 --margin=2,4 --multi --tiebreak=index'

if has('nvim')
  " use floating window (via https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294)
  let g:fzf_layout = { 'window': 'lua windows.openCenteredFloat()' }

  " Search buffers + project files, inspired by https://github.com/junegunn/fzf/issues/274
  " See also https://github.com/junegunn/fzf/blob/master/README-VIM.md
  command! FZFMixed call fzf#run(fzf#wrap({
  \ 'source': 'echo "'.luaeval('fuzzy.getBufferNames()').'"; rg --files',
  \ 'options': '--header-lines=1 --ansi --tiebreak=index'
  \ }))
  nnoremap , :FZFMixed<CR>
  nnoremap <leader><leader> :FZFMixed<CR>

  " When launching vim, if no file was provided (or there were multiple), launch FZFMixed automatically
  function! s:fzf_on_launch()
    if @% =~ "man://"
      " for some reason, using vim as a man reader opens 2 buffers, but we don't want FZFMixed here
      return
    endif
    if @% == "" || bufexists(2)
      FZFMixed
    endif
  endfunction
  autocmd VimEnter * call <SID>fzf_on_launch()
endif

" Custom MRU based on this example: https://github.com/junegunn/fzf/wiki/Examples-(vim)
command! FZFMru call fzf#run(fzf#wrap({
\ 'source':  filter(copy(v:oldfiles), "v:val !~ 'term:\\|fugitive:\\|NERD_tree_\\|__CtrlSF\\|^/tmp/\\|.git/'")
\ }))
nnoremap gm :FZFMru<CR>

" Sibling file selector
nnoremap <silent> <leader>- :Files <C-r>=expand("%:h")<CR>/<CR>

" fugitive
nmap gs :Gstatus<CR>
nmap gb :Gblame<CR>
nmap gl :Git log %<CR>

" Splitjoin
let g:splitjoin_curly_brace_padding = 0
let g:splitjoin_trailing_comma = 1

" nvim-miniyank (lighter-weight YankRing workalike)
let g:miniyank_maxitems = 25
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
nmap <C-p> <Plug>(miniyank-cycle)

" VimWiki
let g:vimwiki_ext2syntax = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{
  \ 'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
  \ 'diary_rel_path': 'journal/', 'diary_index': 'index',
  \ 'diary_header': 'Journal', 'diary_sort': 'asc'
  \ }]

let g:EditorConfig_core_mode = 'python_external'    " Speeds up load time by ~150ms

" }}}
" {{{ Autosave
"===============================================================================

" Save current file every time we leave insert mode or leave vim
augroup autoSaveAndRead
  autocmd!
  " autocmd InsertLeave,FocusLost * call <SID>autosave()
  autocmd WinLeave,FocusLost * call <SID>autosave()
  autocmd CursorHold * silent! checktime
augroup END

function! <SID>autosave()
  if &filetype !=# 'ctrlsf' && (filereadable(expand('%')) == 1)
    update
  endif
endfunction

" <escape> in normal mode also saves
nnoremap <esc> :call <SID>autosave()<CR>

" }}}
" {{{ Key Bindings: Visual mode
"===============================================================================

" Tab modifies indent in visual mode; make < > shifts keep selection
vnoremap <S-Tab> <gv
vnoremap <Tab> >gv
vnoremap < <gv
vnoremap > >gv

" make . and macros work on visual selections (via https://www.reddit.com/r/vim/comments/3y2mgt/)
" Note: the . command must take effect at the start of each line
vnoremap . :norm.<CR>
xnoremap @ :normal @

" Repeat the last used macro:
nnoremap Q @@

" }}}
" {{{ Key Bindings: Moving around
"===============================================================================

" Swap jumplist bindings (left => back, right => forward)
nnoremap <C-o> <C-i>
nnoremap <C-i> <C-o>

" g;    - move back in the change list
" g,    - move forward in the change list
" gi    - move to the last insert, and re-enter insert mode
" {     - move back one paragraph
" }     - move forward one paragraph

nnoremap <Backspace> <C-^>
nnoremap <C-t> :tabn<CR>

" Moving between windows
nmap <silent> <C-j> <C-w>j
nmap <silent> <C-k> <C-w>k
nmap <silent> <C-h> <C-w>h
nmap <silent> <C-l> :lua windows.moveRight()<CR>
nnoremap <silent> <leader>a :lua windows.vsplitAlternateFiles()<CR>
nnoremap <silent> <leader>w :lua windows.toggleLocationList()<CR>

" Automatically resize/equalize splits when vim is resized
autocmd vimrc VimResized * wincmd =

" Swap ` and ' for mark jumping:
nnoremap ' `
nnoremap ` '

" Global mark conventions
" Uppercase marks persist between sessions, so they're useful for accessing
" common files quickly. Make the following dotfiles always accessible:
autocmd vimrc BufLeave vimrc,init.vim     normal! mV
autocmd vimrc BufLeave zshrc              normal! mZ

" Leave a mark behind in the most recently accessed file of certain types.
" via https://www.reddit.com/r/vim/comments/41wgqf/do_you_regularly_use_manual_marks_if_yes_how_do/cz5qfqr
autocmd vimrc BufLeave *.css,*.scss,*.styl normal! mS
autocmd vimrc BufLeave *.html             normal! mH
autocmd vimrc BufLeave README.md          normal! mR
autocmd vimrc BufLeave package.json       normal! mP
autocmd vimrc BufLeave *.js,*.jsx         normal! mJ
autocmd vimrc BufLeave *.ts,*.tsx         normal! mT
autocmd vimrc BufLeave *.gql              normal! mG

" automatically close corresponding loclist when quitting a window
autocmd vimrc QuitPre * if &filetype != 'qf' | silent! lclose | endif

" }}}
" {{{ Key Bindings: Misc
"===============================================================================
" Use ':w!!' to save a root-owned file using sudo:
cnoremap w!! w !sudo tee % >/dev/null

inoremap <C-c> <Esc>

" Use custom `todosince` script as "make" program, for populating quickfix window
set makeprg=todosince\ \-\-output\ vimgrep
nmap <leader>t :silent make<CR>

" Make n/N always go in consistent directions:
noremap <silent> n /<CR>
noremap <silent> N ?<CR>

" yank to system clipboard:
vnoremap <Leader>y "+y

" Resize window with arrow keys
nnoremap <Left> :vertical resize -4<CR>
nnoremap <Right> :vertical resize +4<CR>
nnoremap <Up> :resize -4<CR>
nnoremap <Down> :resize +4<CR>

" Home row bindings for command mode:
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" }}}
" {{{ Folding
"===============================================================================
set foldlevelstart=99
set foldmethod=syntax
autocmd vimrc FileType vim set foldmethod=marker

" }}}
" {{{ Filetype-specific settings
"===============================================================================
autocmd vimrc BufNewFile,BufRead *.md set filetype=markdown
autocmd vimrc BufNewFile,BufRead Procfile set filetype=sh

" sql, see https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1

" html
iabbrev target="_blank" target="_blank" rel="noopener"

let g:vim_json_syntax_conceal = 0

" Hack to open help in vsplit by default
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

autocmd vimrc FileType gitcommit set tabstop=4
" }}}

" Fix for gx not opening urls correctly in recent versions of netrw
" Should remove this once a fix has been merged. See https://github.com/vim/vim/issues/4738
if has('macunix')
  function! OpenURLUnderCursor()
    let s:uri = expand('<cWORD>')
    let s:uri = substitute(s:uri, '?', '\\?', '')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction
  nnoremap gx :call OpenURLUnderCursor()<CR>
endif

" Load any machine-specific config from another file, if it exists
try
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry
