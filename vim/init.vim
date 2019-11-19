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
Plug 'w0rp/ale',                    { 'tag': 'v2.6.0' }
Plug 'vim-airline/vim-airline',     { 'commit': '2db9b27' }
Plug 'justinmk/vim-sneak',          { 'commit': '9eb89e4' }
Plug 'dyng/ctrlsf.vim',             { 'commit': 'bf3611c' }
Plug 'junegunn/fzf',                { 'tag': '0.18.0', 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',            { 'commit': '359a80e' }
Plug 'airblade/vim-gitgutter',      { 'commit': '1725c13' }
Plug 'scrooloose/nerdtree',         { 'tag': '6.2.0', 'on': 'NERDTreeToggle' }
Plug 'PhilRunninger/nerdtree-buffer-ops', { 'commit': 'f5e77b8', 'on': 'NERDTreeToggle' }

" coc.nvim
Plug 'neoclide/coc.nvim',           {'tag': 'v0.0.74', 'do': { -> coc#util#install({'tag':1})}}
Plug 'neoclide/coc-tsserver',       {'tag': '1.4.4', 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json',           {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css',            {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-pairs',          {'tag': '1.2.18', 'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets',       {'tag': '2.1.5', 'do': 'yarn install --frozen-lockfile'}

" tpope appreciation section
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-repeat',            { 'commit': '7a6675f' }     " Enable . repeat for plugin operations (eg. gitgutter)
Plug 'tpope/vim-obsession',         { 'commit': '4ab72e0' }     " start a session file with :Obsession
Plug 'tpope/vim-surround',          { 'commit': '42e9b46' }
Plug 'tpope/vim-unimpaired',        { 'commit': '11dc568' }
Plug 'tpope/vim-fugitive',          { 'commit': '06e3420' }
Plug 'tpope/vim-rhubarb',           { 'commit': '9edacf9' }
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }

" Yanking and clipboard
Plug 'bfredl/nvim-miniyank',           { 'commit': 'b263f7c' }
Plug 'machakann/vim-highlightedyank',  { 'commit': '51e25c9' }

" Editing modifications
Plug 'AndrewRadev/splitjoin.vim',   { 'commit': '0dc8587' }     " gS and gJ to split/join lines
Plug 'tomtom/tcomment_vim',         { 'commit': '3d0a997' }

" Indentation, etc. Autodetect, but override with .editorconfig if present:
" Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' }   " TODO: load lazily, w/o input lag

" language-specific plugins
Plug 'tpope/vim-ragtag',            { 'commit': '5d3ce9c' }
Plug '~/dotfiles/vim/downloaded_plugins/dbext', {'for': ['sql']}
Plug '~/dotfiles/vim/downloaded_plugins/nerdtree_menu_terminal'
Plug 'junegunn/vim-xmark',          { 'commit': '6dd673a', 'do': 'make', 'for': 'markdown' }

" Color/Theme/syntax related plugins
"Plug 'morhetz/gruvbox',             { 'commit': 'cb4e7a5' }     " brown/retro. :set bg=dark
Plug 'arcticicestudio/nord-vim',    { 'tag': 'v0.12.0' }
Plug 'sheerun/vim-polyglot',        { 'commit': '3ddca5d' }     " syntax highlighting for many languages
Plug 'jparise/vim-graphql'

" Misc
Plug 'vimwiki/vimwiki',             { 'commit': '417490f' }
Plug 'Valloric/ListToggle',         { 'commit': '2bc7857' }
Plug 'danro/rename.vim',            { 'commit': 'f133763' }

" Enabled periodically, but not by default:
" Plug 'takac/vim-hardtime',          { 'commit': 'acf59c8' }
" Plug 'mbbill/undotree',             { 'commit': '39e5cf0' }
" Plug 'tweekmonster/startuptime.vim'
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
set hidden                  " TODO: revisit this. Hides instead of unloads buffers
set autoread                " reload files on changes (ie. changing git branches)
set scrolloff=3             " # of lines always shown above/below the cursor

" Indenting & white space
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
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
set splitright
set splitbelow

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

  lua require('navigation')
elseif $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color'
  set t_Co=256    " 256 colours for regular vim if the terminal can handle it.
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
let g:polyglot_disabled = ['markdown']
highlight link jsFuncCall jsObjectProp
highlight link NERDTreeOpenBuffer SpecialChar

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
" {{{ coc.nvim
"===============================================================================

" Suggested settings from https://github.com/neoclide/coc.nvim
set nobackup
set nowritebackup
set updatetime=300
set completeopt=menuone,noselect,noinsert
set shortmess+=c

inoremap <C-c> <Esc>

" Auto-indent new inner line after typing {<CR> -- see https://github.com/neoclide/coc-pairs/issues/13
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use tab to trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <F2> <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> ge <Plug>(coc-references)
autocmd CursorHold * silent call CocActionAsync('highlight')

" Support for "code actions" in normal and visual mode
nmap <F3> <Plug>(coc-codeaction)
xmap <F3> <Plug>(coc-codeaction-selected)

" coc-snippets (snippets are stored in vim/personal_snippets)
imap <C-j> <Plug>(coc-snippets-expand-jump)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
nnoremap <leader>s :CocCommand snippets.editSnippets

" }}}
" {{{ ALE
"===============================================================================
" Move between errors
nmap <silent> [w :call ale#loclist_jumping#Jump('before', 1)<CR>
nmap <silent> ]w :call ale#loclist_jumping#Jump('after', 1)<CR>

" Show full error output in preview window (close window with 'q')
" TODO: toggle preview window off with C-e
nmap <silent> <C-e> <Plug>(ale_detail)

if !hlexists('ALEVirtualTextError')
  highlight link ALEVirtualTextError ErrorMsg
  highlight link ALEVirtualTextWarning MoreMsg
endif
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '  ---> '
let g:ale_open_list = 0   " Don't open the loclist when reading a file (if there are errors)
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 100
let g:ale_sign_column_always = 1
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '✗'
let g:ale_echo_msg_format = '[%linter% %code%] %s'
let g:ale_linters = {
\   'javascript': ['eslint', 'flow-language-server'],
\   'typescript': ['eslint', 'tsserver', 'typecheck'],
\}
let g:ale_fixers = {
\   'css': ['prettier', 'trim_whitespace', 'remove_trailing_lines'],
\   'javascript': ['eslint', 'trim_whitespace', 'remove_trailing_lines'],
\   'ocaml': ['ocamlformat'],
\   'json': ['jq'],
\   'reason': ['refmt'],
\   'rust': ['rustfmt'],
\   'sql': ['pgformatter'],
\   'typescript': ['eslint', 'trim_whitespace', 'remove_trailing_lines']
\}
" let g:ale_fix_on_save = 1
nnoremap <leader>f :ALEFix<CR>

" }}}
" {{{ grepping (:grep, CTRLSF.vim, etc)
"===============================================================================

if executable("rg")
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

function! IsNerdTreeOpen()
  return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

" Open Nerdtree to the current file. Note NERDTreeFind is very similar to this, but it always expands
" the tree from the root, so it's not quite what I want
function! OpenNerdTree()
  let l:current_filename = expand('%:t')
  let l:full_file_path = expand('%')
  " check if current file is visible in nerdtree. Note this is 'best effort', if a different file in
  " the tree has the same name, it will be considered a valid match as well
  if IsNerdTreeOpen()
    NERDTreeFocus
    let l:current_file_is_visible = search(l:current_filename, 'n') != 0
    if (l:current_file_is_visible ==# 0)
      execute 'NERDTree ' . fnamemodify(l:full_file_path, ':h')
    endif
  else
    NERDTree %
  endif
  call search(l:current_filename)  " move cursor to current file
endfunction

nnoremap - :call OpenNerdTree()<CR>

function! UnloadFile()
  if &filetype ==# 'ctrlsf' || &filetype ==# 'nerdtree'
    bdelete
  elseif IsNerdTreeOpen()
    let l:buffer_number = bufnr('%')
    bnext
    execute 'bdelete ' . l:buffer_number
  else
    bdelete
  endif
endfunction
nnoremap <silent> <C-u> :call UnloadFile()<CR>

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

" ListToggle
let g:lt_location_list_toggle_map = '<leader>l'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" FZF
" More tips: https://github.com/junegunn/fzf/wiki/Examples-(vim)
nnoremap <leader><leader> :FZF<CR>
nnoremap <C-t> :Buffers<CR>
nnoremap <leader>h :History:<CR>
let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vertical split',
  \ 'ctrl-t': 'tab split',
  \ ':': 'close'
  \ }

" use floating window for fzf (via https://github.com/junegunn/fzf.vim/issues/664#issuecomment-476438294)
if has('nvim')
  let $FZF_DEFAULT_OPTS='--layout=reverse --color gutter:-1 --margin=2,4'
  let g:fzf_layout = { 'window': 'lua NavigationFloatingWin()' }

  " Custom MRU using FZF
  " Based on the example here: https://github.com/junegunn/fzf/wiki/Examples-(vim)
  command! FZFMru call fzf#run({
  \ 'source':  filter(copy(v:oldfiles), "v:val !~ 'fugitive:\\|__CtrlSF\\|^/tmp/\\|.git/'"),
  \ 'sink':    'edit',
  \ 'options': '-m -x +s',
  \ 'window': 'lua NavigationFloatingWin()',
  \ 'down':    '40%'
  \ })
  nnoremap gm :FZFMru<CR>
endif

" Sibling file selector
nnoremap <silent> <leader>- :Files <C-r>=expand("%:h")<CR>/<CR>

" gitgutter
" use [c and ]c to jump to next/previous changed "hunk"
nmap <leader>r <Plug>(GitGutterUndoHunk)
nmap <leader>ga <Plug>(GitGutterStageHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)

" fugitive
nmap <leader>gs :Gstatus<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gb :Gblame<CR>

" vim-airline:
let g:airline_theme = 'nord'
let g:airline_extensions = ['ale', 'branch', 'tabline']   " Only enable extensions I use, improves performance
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_idx_mode = 1

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

" vim-ragtag
let g:ragtag_global_maps = 1
imap <C-l> <C-x>/

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

nnoremap <leader>a :lua VsplitAlternateFiles()<CR>

" g;    - move back in the change list
" g,    - move forward in the change list
" gi    - move to the last insert, and re-enter insert mode
" {     - move back one paragraph
" }     - move forward one paragraph

" Navigating between buffers:
" These first bindings don't work with nnoremap for some reason (?)
nmap <C-h> <Plug>AirlineSelectPrevTab
nmap <C-l> <Plug>AirlineSelectNextTab
nnoremap <Backspace> <C-^>
nnoremap <silent> <C-n> :lua ToNextWindow()<CR>

" Open new vsplit and move to it:
nnoremap <leader>v <C-w>v<C-w>l

" Automatically resize/equalize splits when vim is resized
autocmd vimrc VimResized * wincmd =

" Save current file every time we leave insert mode or leave vim
augroup autoSaveAndRead
  autocmd!
  "autocmd InsertLeave,FocusLost * call <SID>autosave()
  autocmd CursorHold * silent! checktime
augroup END

function! <SID>autosave()
  if &filetype !=# 'ctrlsf' && (filereadable(expand('%')) == 1)
    update
    call ale#Queue(0)   " Trigger linting immediately
  endif
endfunction

" <escape> in normal mode also saves
nnoremap <esc> :call <SID>autosave()<CR>

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

" sql, see https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1

" html
iabbrev target="_blank" target="_blank" rel="noopener"

" JavaScript
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

" JSON files
let g:vim_json_syntax_conceal = 0
autocmd BufRead,BufNewFile *.json set filetype=json

" Hack to open help in vsplit by default
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

autocmd vimrc FileType gitcommit set tabstop=4
" }}}

" Load any machine-specific config from another file, if it exists
try
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry
