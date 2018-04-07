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
"
" * Run :PlugInstall to install
" * Run :PlugUpdate to update
"
call plug#begin('~/.vim/plugged')

" Essentials
Plug 'w0rp/ale',                    { 'commit': '70fdeb7' }
Plug 'vim-airline/vim-airline',     { 'commit': '6c8d0f5' }
Plug 'justinmk/vim-sneak',          { 'commit': '9eb89e4' }
Plug 'dyng/ctrlsf.vim',             { 'commit': '5c40f36' }
Plug 'junegunn/fzf',                { 'tag': '0.16.6', 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',            { 'commit': '4b9e2a0' }
Plug 'roxma/nvim-completion-manager',  { 'commit': '21c4b61' }
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'airblade/vim-gitgutter',      { 'commit': '78d83c7' }

" tpope appreciation section
Plug 'tpope/vim-repeat',            { 'commit': '7a6675f' }     " Enable . repeat for plugin operations (eg. gitgutter)
Plug 'tpope/vim-obsession',         { 'commit': '4ab72e0' }     " start a session file with :Obsession
Plug 'tpope/vim-surround',          { 'commit': '42e9b46' }
Plug 'tpope/vim-unimpaired',        { 'commit': '11dc568' }
Plug 'tpope/vim-fugitive',          { 'commit': '935a2cc' }
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }

" Yanking and clipboard
Plug 'bfredl/nvim-miniyank',           { 'commit': 'b263f7c' }
Plug 'roxma/vim-tmux-clipboard',       { 'commit': '24e6363' }
Plug 'machakann/vim-highlightedyank',  { 'commit': '5fb7d0f' }

" Editing modifications
Plug 'tommcdo/vim-exchange',        { 'commit': 'b82a774' }
Plug 'AndrewRadev/splitjoin.vim',   { 'commit': '4b062a0' }     " gS and gJ to split/join lines
Plug 'jiangmiao/auto-pairs',        { 'commit': 'f0019fc' }
Plug 'tomtom/tcomment_vim',         { 'commit': '3d0a997' }

" Text objects
" They're basically all based on vim-textobj-user. For more, see https://github.com/kana/vim-textobj-user/wiki
Plug 'kana/vim-textobj-user'
Plug 'jceb/vim-textobj-uri'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-function'
Plug 'thinca/vim-textobj-function-javascript'   " eg. vif
Plug 'Julian/vim-textobj-variable-segment'      " eg. viv
Plug 'whatyouhide/vim-textobj-xmlattr'          " eg. vix

" Indentation, etc. Autodetect, but override with .editorconfig if present:
Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' }   " TODO: load lazily, w/o input lag

" Javascript/CSS/HTML-related plugins
Plug 'moll/vim-node',               { 'commit': '13b3121' }     " Lazy loading doesn't work for some reason
Plug 'othree/csscomplete.vim',      { 'for': ['css', 'stylus', 'less'] }
Plug 'tpope/vim-ragtag',            { 'commit': '0ef3f6a', 'for': ['html', 'xml', 'mustache', 'javascript'] }
Plug 'mhartington/nvim-typescript', { 'commit': 'f33d0bc', 'for': ['typescript'], 'do': ':UpdateRemotePlugins' }

" Other language-specific plugins
Plug 'reasonml-editor/vim-reason-plus',  { 'for': ['reason'] }
Plug '~/dotfiles/vim/downloaded_plugins/dbext', {'for': ['sql']}
Plug 'elzr/vim-json',               { 'commit': 'f5e3181', 'for': ['json'] }
Plug 'junegunn/vim-xmark',          { 'commit': '6dd673a', 'do': 'make', 'for': 'markdown' }

" Color/Theme/syntax related plugins
Plug 'morhetz/gruvbox',             { 'commit': '2ea3298' }     " default colorscheme. brown/retro. :set bg=dark
Plug 'sheerun/vim-polyglot',        { 'commit': 'a61ab44' }     " syntax highlighting for many languages
Plug 'lilydjwg/colorizer',          { 'commit': '9d6dc32', 'on': 'ColorToggle' }

" Misc
Plug 'vimwiki/vimwiki',             { 'tag':    'v2.2.1'  }
Plug 'Valloric/ListToggle',         { 'commit': '2bc7857' }
Plug 'troydm/zoomwintab.vim',       { 'commit': 'b7a940e' }
Plug 'danro/rename.vim',            { 'commit': 'f133763' }
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neosnippet',           { 'commit': '0e829d5' }

" Enabled periodically, but not by default:
" Plug 'takac/vim-hardtime',          { 'commit': 'acf59c8' }
" Plug 'mbbill/undotree',             { 'commit': '39e5cf0' }
" Plug 'tweekmonster/startuptime.vim'

" Try later:
" Plug 'zefei/vim-colortuner'

" Load some of the more sluggish plugins on first insert mode enter,
" to improve startup time:
" augroup load_on_insert
"   autocmd!
"   autocmd InsertEnter * call plug#load('myslowplugin.vim') | autocmd! load_on_insert
" augroup END

call plug#end()
" }}} (end of plugin setup)

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

" }}}

" {{{ Display/window settings
"===============================================================================
syntax on
set number                  " line number gutter
set ruler                   " line numbers at bottom of page
set showcmd
set title
set wildmenu
set wildignore=.svn,.git,.gitignore,*.pyc,*.so,*.swp,*.jpg,*.png,*.gif,node_modules,_site
set laststatus=2            " Always show a status line for lowest window in a split
set cursorline              " highlight the full line that the cursor is currently on
set colorcolumn=80,100      " Highlight these columns with a different bg

" Automatically set quickfix height
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
autocmd vimrc FileType qf call AdjustWindowHeight(4, 24)       " 2nd arg=> max height
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line('$'), a:maxheight]), a:minheight]) . 'wincmd _'
endfunction
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
set formatoptions=qrn1j
nnoremap j gj
nnoremap k gk
" }}}

" {{{ Neovim-specific settings
"===============================================================================
if has('nvim')
    " True Color support
    " For this to work, you need recent versions of iTerm2 and tmux (2.2+)
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let &t_8b="\e[48;2;%ld;%ld;%ldm"

    set inccommand=split

    " See https://github.com/neovim/neovim/wiki/FAQ
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

    " Nicer navigation for Neovim's terminal buffers
    " via https://github.com/neovim/neovim/pull/2076#issuecomment-76998265
    tnoremap <esc> <c-\><c-n>
    tnoremap <A-j> <c-\><c-n><c-w>j
    tnoremap <A-k> <c-\><c-n><c-w>k
    tnoremap <A-h> <c-\><c-n><c-w>h
    tnoremap <A-l> <c-\><c-n><c-w>l
    tnoremap <A-v> <c-\><c-n><c-w><c-v>
    tnoremap <A-s> <c-\><c-n><c-w><c-s>
    autocmd vimrc WinEnter term://* call feedkeys('i')
elseif $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color' || $COLORTERM ==# 'gnome-terminal'
    set t_Co=256            " 256 colours for regular vim if the terminal can handle it.
endif
" }}}

" {{{ Colorscheme & syntax
"===============================================================================
color gruvbox
set background=dark
highlight Comment cterm=italic

" highlight trailing whitespace and excessive line length:
augroup ErrorHighlights
    autocmd!
    autocmd InsertEnter * call clearmatches()
    autocmd InsertLeave * call matchadd('ErrorMsg', '\s\+$', 100) | call matchadd('ErrorMsg', '\%>140v.\+', 100)
augroup END


" Show syntax highlighting groups for word under cursor with <leader>s
" From Vimcasts #25: http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader>S :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

" {{{ Autocompletion and Tab behavior
"===============================================================================
" May want to consider replacing "menuone" with "menu" (see vim help)
set completeopt=menuone,preview,longest

" Traverse completions with <Tab>
inoremap <expr> <TAB> pumvisible() ? '<C-n>' : '<TAB>'
inoremap <expr> <S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'

" nvim-completion-manager config
" Includes a hack to work around <CR> conflicts with auto-pairs
"imap <expr> <CR> (pumvisible() ? "\<c-y>\<Plug>(expand_or_nl)" : "\<CR>")
imap <expr> <Plug>(expand_or_nl) (cm#completed_is_snippet() ? "\<C-U>":"\<CR>")
imap <expr> <silent> <cr>  (pumvisible() ? "\<c-y>\<Plug>(cm_inject_snippet)\<Plug>(expand_or_nl)\<c-r>=AutoPairsReturn()\<cr>" : "\<cr>\<c-r>=AutoPairsReturn()\<cr>")

inoremap <C-c> <Esc>
set shortmess+=c

" Extra config to make snippet expansion work correctly with <CR>:
inoremap <silent> <c-u> <c-r>=cm#sources#neosnippet#trigger_or_popup("\<Plug>(neosnippet_expand_or_jump)")<cr>

" LanguageClient integration
" note: also need to install language servers globally (eg with `yarn global add`)
let g:LanguageClient_serverCommands = {
\ 'javascript': ['flow-language-server', '--stdio'],
\ 'javascript.jsx': ['flow-language-server', '--stdio'],
\ 'ocaml': ['ocaml-language-server', '--stdio'],
\ 'reason': ['ocaml-language-server', '--stdio'],
\ 'typescript': ['typescript-language-server', '--stdio'],
\ }
let g:LanguageClient_autoStart = 1
autocmd vimrc FileType javascript,javascript.jsx,ocaml,reason,typescript nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <F3> :call LanguageClient_textDocument_formatting()<cr>

" for echodoc; the mode is already visible in airline
set noshowmode
" }}}

" {{{ netrw
"===============================================================================

" General settings and bindings
let g:netrw_banner = 0
let g:netrw_home = '~/dotfiles'
let g:netrw_browse_split = 4   " Open files in the last window that was active
let g:netrw_altv = 1
autocmd vimrc FileType netrw nmap <buffer> <C-t> t
autocmd vimrc FileType netrw nmap <buffer> <C-v> v<C-w>=

function! DeleteEmptyBuffers()
    let [l:i, l:n; l:empty] = [1, bufnr('$')]
    while l:i <= l:n
        if bufexists(l:i) && bufname(l:i) ==# ''
            call add(l:empty, l:i)
        endif
        let l:i += 1
    endwhile
    if len(l:empty) > 0
        exe 'bdelete' join(l:empty)
    endif
endfunction

" TODO: handle case where Lex is already open, but not to the dir of the current file.
" Can we jump to that file in that case?

" Experiment: Lexplore wrapper
" see https://github.com/tpope/vim-vinegar/blob/master/plugin/vinegar.vim for tips
function! <SID>lex_netrw()
  let l:current_filename = expand('%:t')
  let b:lexp_is_open = exists('t:lexp_buf_num') && bufwinnr(t:lexp_buf_num) != -1

  if b:lexp_is_open
    1wincmd w   " Move to first window (assumed to be Lexplore)
  else
    Lexplore %:h
    vertical resize 25   " Use a fixed width, instead of a % of space
    let t:lexp_buf_num = bufnr('%')
    silent !DeleteEmptyBuffers()   " Lexplore leaves a bunch of stray buffers around
  endif
  call search(l:current_filename)   " move cursor to the current file
endfunction
nnoremap - :call <SID>lex_netrw()<CR>

" }}}

" {{{ Plugin customization
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
  \'ctrl-s': 'split',
  \'ctrl-v': 'vertical split',
  \'ctrl-t': 'tab split',
  \':': 'close' }

" Custom MRU using FZF
" Based on the example here: https://github.com/junegunn/fzf/wiki/Examples-(vim)
command! FZFMru call fzf#run({
\ 'source':  filter(copy(v:oldfiles), "v:val !~ 'fugitive:\\|__CtrlSF\\|^/tmp/\\|.git/'"),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })
nnoremap gm :FZFMru<CR>

" gitgutter
" use [c and ]c to jump to next/previous changed "hunk"
nmap <leader>a <Plug>GitGutterStageHunk
nmap <leader>r <Plug>GitGutterRevertHunk

" vim-airline:
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_symbols.branch    = '⭠'
let g:airline_symbols.readonly  = '⭤'
let g:airline_symbols.linenr    = '⭡'
let g:airline_theme = 'gruvbox'
let g:airline_extensions = ['ale', 'branch', 'tabline']   " Only enable extensions I use, improves performance
let g:airline_highlighting_cache = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_idx_mode = 1

" jumping to tabs:
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6

" Colorizer
nnoremap <leader><F2> :ColorToggle<CR>

" Undotree
nnoremap <F3> :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1

" Splitjoin (javascript setting)
" see https://github.com/AndrewRadev/splitjoin.vim/issues/67#issuecomment-91582205
let g:splitjoin_javascript_if_clause_curly_braces = 'Sj'

" Neosnippet
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory = '~/.vim/personal_snippets'
let g:neosnippet#disable_runtime_snippets = { '_': 1 }
let g:neosnippet#scope_aliases = {}
let g:neosnippet#scope_aliases['jsx'] = 'html'
let g:neosnippet#enable_completed_snippet=1
nnoremap <leader>s :NeoSnippetEdit -vertical -split<CR>

" CtrlSF.vim
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

" nvim-miniyank (lighter-weight YankRing workalike)
let g:miniyank_maxitems = 25
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
nmap <C-p> <Plug>(miniyank-cycle)

" Auto-pairs
inoremap <silent> <C-l> <ESC>:call AutoPairsJump()<CR>a
let g:AutoPairsShortcutFastWrap = '<C-w>'
let g:AutoPairsMultilineClose = 0

" VimWiki
let g:vimwiki_ext2syntax = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
                    \  'diary_rel_path': 'journal/', 'diary_index': 'index',
                    \  'diary_header': 'Journal', 'diary_sort': 'asc'}]

let g:EditorConfig_core_mode = 'python_external'    " Speeds up load time by ~150ms

" vim-ragtag
let g:ragtag_global_maps = 1
autocmd vimrc FileType html,javascript imap <C-k> <C-x>/
" }}}

" {{{ Key Bindings: Visual mode
"===============================================================================

" Tab modifies indent in visual mode,
" make < > shifts keep selection
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

" Navigating between buffers:
" These first bindings don't work with nnoremap for some reason (?)
nmap <C-h> <Plug>AirlineSelectPrevTab
nmap <C-l> <Plug>AirlineSelectNextTab
nnoremap <Backspace> <C-^>
nnoremap <silent> <C-u> :bd<CR>

" Easier movement between windows (Neovim only?):
nnoremap <A-j> <c-w>j
nnoremap <A-k> <c-w>k
nnoremap <A-h> <c-w>h
nnoremap <A-l> <c-w>l
nnoremap <A-c> <c-w>c
nnoremap <A-s> <c-w>s
nnoremap <A-v> <c-w>v
nnoremap <A-o> <c-w>o
nnoremap <A-z> :ZoomWinTabToggle<CR>
nnoremap <A-p> <c-w>p       " most recently used window

function! <SID>next_window()
    wincmd w
    if &filetype ==# 'qf' || &filetype ==# 'netrw'
        wincmd w
    endif
endfunction
nnoremap <C-n> :call <SID>next_window()<CR>

nnoremap <C-S-k> <c-w>W
inoremap <A-j> <c-\><c-n><c-w>j
inoremap <A-k> <c-\><c-n><c-w>k
inoremap <A-h> <c-\><c-n><c-w>h
inoremap <A-l> <c-\><c-n><c-w>l
cnoremap <A-j> <c-\><c-n><c-w>j
cnoremap <A-k> <c-\><c-n><c-w>k
cnoremap <A-h> <c-\><c-n><c-w>h
cnoremap <A-l> <c-\><c-n><c-w>l
" Open new vsplit and move to it:
nnoremap <silent> vv <C-w>v<C-w>l
nnoremap <leader>o :only<CR>

" Automatically resize/equalize splits when vim is resized
autocmd vimrc VimResized * wincmd =

" Save current file every time we leave insert mode or leave vim
augroup autoSaveAndRead
    autocmd!
    autocmd InsertLeave,FocusLost * call <SID>autosave()
    autocmd CursorHold * silent! checktime
augroup END

function! <SID>autosave()
    if &filetype !=# 'ctrlsf' && (filereadable(expand('%')) == 1)
        update
    endif
endfunction

" <escape> in normal mode also saves
nmap <esc> :call <SID>autosave()<CR>

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
autocmd vimrc BufLeave *.css,*.styl       normal! mC
autocmd vimrc BufLeave *.styl             normal! mS
autocmd vimrc BufLeave *.html,*.mustache  normal! mH
autocmd vimrc BufLeave README.md          normal! mR
autocmd vimrc BufLeave package.json       normal! mP
autocmd vimrc BufLeave *.js,*.jsx         normal! mJ
autocmd vimrc BufLeave *.test.js,*.test.jsx   normal! mT

" ProTip: After opening a file with a global mark, you can change vim's cwd to
" the file's location with ":cd %:h"

" Move between errors (using ale)
nnoremap <silent> <C-j> :call ale#loclist_jumping#Jump('after', 1)<CR>
nnoremap <silent> <C-k> :call ale#loclist_jumping#Jump('before', 1)<CR>

" More ale/loclist config
let g:ale_open_list = 0   " Don't open the loclist when reading a file (if there are errors)
let g:ale_lint_on_text_changed = 'normal'
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'javascript': ['eslint', 'flow'],
\   'typescript': ['tslint', 'tsserver', 'typecheck'],
\}
let g:ale_linter_aliases = {
\   'reason': 'ocaml',
\   'less': 'css'
\}
let g:ale_fixers = {
\   'javascript': ['eslint']
\}
nnoremap <leader>f :ALEFix<CR>

" Enabling lint_on_insert_leave currently makes the cursor jump around annoyingly
" The following line was an attempt to fix this, but it suffered from the same issue: 
" autocmd vimrc InsertLeave * call ale#Queue(500)
let g:ale_lint_on_insert_leave = 0

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

" console.log convenience mapping. Inserts a console.log() call with the variable under the cursor
autocmd vimrc FileType javascript nnoremap <Leader>cl yiwoconsole.log(`<c-r>": ${<c-r>"}`)<Esc>hh

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
set pastetoggle=<F2>   " Have had problems with <F2>, see http://stackoverflow.com/q/7885198/351433
" }}}

" {{{ Filetype-specific settings
"===============================================================================
" filetype detection for syntax highlighting
autocmd vimrc BufNewFile,BufRead *.md set filetype=markdown
autocmd vimrc BufNewFile,BufRead *.mustache set filetype=mustache
autocmd vimrc FileType mustache set ft=html.mustache

" sql
" see https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1

" html
iabbrev target="_blank" target="_blank" rel="noopener"

" CSS-like autocomplete for preprocessor files:
autocmd vimrc FileType css,sass,scss,stylus,less set omnifunc=csscomplete#CompleteCSS

" JavaScript
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

" JSON files
let g:vim_json_syntax_conceal = 0
autocmd BufRead,BufNewFile *.json set filetype=json

" Vim files (use K to look up the current word in vim's help files)
autocmd vimrc FileType vim setlocal keywordprg=:help

" Hack to open help in vsplit by default
augroup vimrc_help
    autocmd!
    autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" Reason
" There are a bunch of <localleader> bindings that are handy
" For more on Merlin and vim, see:
"   https://github.com/ocaml/merlin/wiki/vim-from-scratch
"   https://github.com/ocaml/merlin/blob/master/vim/merlin/doc/merlin.txt
" }}}

autocmd vimrc FileType gitcommit set tabstop=4

" Load any machine-specific config from another file, if it exists
try
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry
