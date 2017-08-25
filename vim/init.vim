" General Notes
" * see ":h normal-index" or ":h insert-index" for a list of built-in mappings
" * see ":verbose nmap <C-j>" (for example) for maps setup by plugins or .vimrc
" * profile startup time with "vim --startuptime startup.log"
"
" Reminder (since this file now has folds): zR to open all folds in a file, zM to close them all
" zO to open recursively from cursor, zA to toggle recursively
" See :help fold-manual

set nocompatible            " we're using (neo)vim, not Vi

" {{{ Plugin setup via vim-plug
" ==============================================================================
"
" * Run :PlugInstall to install
" * Run :PlugUpdate to update
"
call plug#begin('~/.vim/plugged')

" vim plugins, managed by vim-plug
Plug 'vim-airline/vim-airline',     { 'commit': '64d9166' }
Plug 'tpope/vim-repeat',            { 'commit': '7a6675f' }     " Enable . repeat for plugin operations (eg. gitgutter)
Plug 'vimwiki/vimwiki',             { 'tag':    'v2.2.1'  }
Plug 'justinmk/vim-sneak',          { 'commit': '9eb89e4' }
Plug 'danro/rename.vim',            { 'commit': 'f133763' }
Plug 'af/YankRing.vim',             { 'commit': '0e4235b', 'on': [] }   " using fork, as v18 isn't officially on GH
Plug 'tpope/vim-obsession',         { 'commit': '4ab72e0' }     " start a session file with :Obsession
Plug 'dyng/ctrlsf.vim',             { 'commit': '881dfbf' }
Plug 'jeetsukumaran/vim-filebeagle',{ 'commit': 'abfb7f9' }
Plug 'junegunn/vim-xmark',          { 'commit': '6dd673a', 'do': 'make', 'for': 'markdown' }
Plug 'mbbill/undotree',             { 'commit': '39e5cf0' }
Plug 'troydm/zoomwintab.vim',       { 'commit': 'b7a940e' }
Plug 'blueyed/vim-diminactive',     { 'commit': '5cb27ae' }
Plug 'takac/vim-hardtime',          { 'commit': 'acf59c8' }
Plug 'Valloric/ListToggle',         { 'commit': '2bc7857' }

" FZF and friends
Plug 'junegunn/fzf',                { 'tag': '0.16.6', 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim',            { 'commit': '687f5e2' }

" Editing modifications
Plug 'tommcdo/vim-exchange',        { 'commit': 'b82a774' }
Plug 'AndrewRadev/splitjoin.vim',   { 'commit': '4b062a0' }     " gS and gJ to split/join lines
Plug 'Raimondi/delimitMate',        { 'commit': '8bc47fd' }
Plug 'tpope/vim-surround',          { 'commit': '42e9b46' }
Plug 'tpope/vim-unimpaired',        { 'commit': '11dc568' }
Plug 'tomtom/tcomment_vim',         { 'commit': '3d0a997' }

" Git/VCS related plugins
Plug 'tpope/vim-fugitive',          { 'commit': '935a2cc' }
Plug 'airblade/vim-gitgutter',      { 'commit': '78d83c7' }

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
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }
Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' }   " TODO: load lazily, w/o input lag

" Javascript/CSS/HTML-related plugins
Plug 'moll/vim-node',               { 'commit': '13b3121' }     " Lazy loading doesn't work for some reason
Plug '1995eaton/vim-better-javascript-completion',  { 'for': ['javascript', 'jsx'] }
Plug 'heavenshell/vim-jsdoc',       { 'for': ['javascript', 'jsx'] }
Plug 'othree/csscomplete.vim',      { 'for': ['css', 'stylus'] }
Plug 'rstacruz/sparkup',            { 'commit': 'd400a57', 'for': ['html', 'xml', 'mustache'] }
Plug 'tpope/vim-ragtag',            { 'commit': '0ef3f6a', 'for': ['html', 'xml', 'mustache', 'jsx'] }

" Other language-specific plugins
Plug 'reasonml-editor/vim-reason',  { 'for': ['reason'] }
Plug '~/dotfiles/vim/downloaded_plugins/dbext', {'for': ['sql']}
Plug 'elzr/vim-json',               { 'commit': 'f5e3181', 'for': ['json'] }

" theme/syntax related plugins
Plug 'sheerun/vim-polyglot',        { 'commit': 'e404a65' }     " syntax highlighting for many languages
Plug 'w0rp/ale',                    { 'commit': '7eec1f2' }
Plug 'lilydjwg/colorizer',          { 'commit': '9d6dc32', 'on': 'ColorToggle' }

" Colour schemes
Plug 'morhetz/gruvbox',             { 'commit': '2ea3298' }     " default. brown/retro. :set bg=dark

" Snippets and tab completion
Plug 'SirVer/UltiSnips',            { 'commit': '71c3972', 'on': [] }  " personal snippets are in this dotfiles repo
Plug 'Shougo/deoplete.nvim',        { 'commit': 'ac4e8b5', 'do': ':UpdateRemotePlugins' }
"Plug 'ajh17/VimCompletesMe',        { 'commit': '146f000' }    " More minimal alternative to deoplete


" Cool plugins that are disabled because they add to startup time:
" Plug 'ashisha/image.vim', { 'commit': 'ae15d1c5' }       " view images in vim (requires `pip install Pillow`)

" plugins for colorscheme dev (not tested yet):
" https://github.com/shawncplus/Vim-toCterm
" https://github.com/guns/xterm-color-table.vim

" Try later:
" Plug 'zefei/vim-colortuner'
" Plug 'mattn/emmet-vim'
" Plug 'jaxbot/github-issues.vim'          " TODO: configure this

" Load some of the more sluggish plugins on first insert mode enter,
" to improve startup time:
augroup load_on_insert
  autocmd!
  autocmd InsertEnter * call plug#load('UltiSnips', 'YankRing.vim') | autocmd! load_on_insert
augroup END

call plug#end()
" }}} (end of plugin setup)

" {{{ General Vim settings
" ==============================================================================

let mapleader = " "         " <leader> is our personal modifier key
set visualbell
set history=500             " longer command history (default=20)
set backspace=indent,eol,start
set noswapfile              " Disable swap files
set lazyredraw              " Speeds up macros by avoiding excessive redraws
"set directory=~/.vim/swp    " where the .swp files go (if enabled)
"set shellpipe=>             " Prevents results from flashing during Ack.vim searches

" File/buffer settings
"autocmd BufWinEnter,BufNewFile * silent tabo    " Ensure only one tab is open
set hidden                  " TODO: revisit this. Hides instead of unloads buffers
set autoread                " reload files on changes (ie. changing git branches)
set encoding=utf-8
set scrolloff=3             " # of lines always shown above/below the cursor

" Indenting & white space
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set breakindent
set showbreak=…
set list listchars=tab:›\ ,trail:·          " mark trailing white space
"set list listchars=tab:›\ ,trail:·,eol:¬   " mark trailing white space (with eol)

" }}}

" {{{ Display/window settings
"===============================================================================
syntax on
set bg=dark
set number                  " line number gutter
set ruler                   " line numbers at bottom of page
set showcmd
set title
set wildmenu
set wildignore=.svn,.git,.gitignore,*.pyc,*.so,*.swp,*.jpg,*.png,*.gif,node_modules,_site
set laststatus=2            " Always show a status line for lowest window in a split
set cursorline              " highlight the full line that the cursor is currently on
set colorcolumn=80,100      " Highlight these columns with a different bg
"set helpheight=99999        " Hack to make help pages open "fullscreen"

" Automatically set quickfix height
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
autocmd FileType qf call AdjustWindowHeight(3, 7)       " 2nd arg=> max height
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
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
set formatoptions=qrn1
nnoremap j gj
nnoremap k gk
autocmd WinEnter * set wrap     " Only wrap the current file (works nice with ctrlsf)
autocmd WinLeave * set nowrap
" }}}

" {{{ Neovim-specific settings
"===============================================================================
if has('nvim')
    " True Color support
    " For this to work, you need recent versions of iTerm2 and tmux (2.2+)
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let &t_8b="\e[48;2;%ld;%ld;%ldm"

    set inccommand=split

    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1     " See https://github.com/neovim/neovim/wiki/FAQ

    " Nicer navigation for Neovim's terminal buffers
    " via https://github.com/neovim/neovim/pull/2076#issuecomment-76998265
    tnoremap <esc> <c-\><c-n>
    tnoremap <A-j> <c-\><c-n><c-w>j
    tnoremap <A-k> <c-\><c-n><c-w>k
    tnoremap <A-h> <c-\><c-n><c-w>h
    tnoremap <A-l> <c-\><c-n><c-w>l
    tnoremap <A-v> <c-\><c-n><c-w><c-v>
    tnoremap <A-s> <c-\><c-n><c-w><c-s>
    autocmd WinEnter term://* call feedkeys('i')
elseif $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256            " 256 colours for regular vim if the terminal can handle it.
endif
" }}}

" {{{ Colorscheme & syntax
"===============================================================================
color gruvbox
set bg=dark
highlight Comment cterm=italic


" Show syntax highlighting groups for word under cursor with <leader>s
" From Vimcasts #25: http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader>h :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

" {{{ Autocompletion and Tab behavior
"===============================================================================
" May want to consider replacing "menuone" with "menu" (see vim help)
set completeopt=menuone,preview,longest

" Use omnicompletion with <Tab> by default:
autocmd FileType * let b:vcm_tab_complete = "omni"

" Traverse completions with <Tab>
inoremap <expr> <TAB> pumvisible() ? '<C-n>' : '<TAB>'
inoremap <expr> <S-TAB> pumvisible() ? '<C-p>' : '<S-TAB>'

" Make <Enter> select the currently highlighted item in the pop up menu:
" This is not necessary with deoplete
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" }}}

" {{{ Plugin customization
"===============================================================================

" vim-hardtime: discourage repeat usage of hjkl
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1
let g:hardtime_maxcount = 2    " (slightly less punishing mode)
let g:list_of_normal_keys = ['h', 'j', 'k', 'l', 'w']
let g:list_of_visual_keys = ['h', 'j', 'k', 'l', 'w']
let g:list_of_insert_keys = []

" vim-diminactive
let g:diminactive_enable_focus = 1

" FileBeagle
let g:filebeagle_show_hidden = 1        " Use 'gh' to toggle- FileBeagle hides lots by default
autocmd FileType filebeagle nmap <buffer> <C-v> <Plug>(FileBeagleBufferSplitVerticalVisitTarget)
autocmd FileType filebeagle nmap <buffer> <C-s> <Plug>(FileBeagleBufferSplitVisitTarget)

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

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

" When launching vim, if no file was provided, launch FZF automatically
function! s:fzf_on_launch()
  if @% == ""
    call fzf#run({'sink': 'e', 'options': '-m -x +s', 'window': 'rightbelow new'})
  endif
endfunction
autocmd VimEnter * call <SID>fzf_on_launch()

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
" Note: the following symbols require a patched font.
" For Monaco, I used https://github.com/fromonesrc/monaco-powerline-vim
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
let g:airline#extensions#tabline#enabled = 1    " Tab line at top of window
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffers_label = 'bufs'
let g:airline#extensions#tabline#show_buffers = 2  " Show buffers no matter how many tabs are open
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#tab_nr_type = 2    " show both splits and tab number
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

let g:deoplete#sources = {}
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.stylus = '.*'
let g:deoplete#sources.stylus = ['omni', 'buffer', 'tags']

" For OCaml/Reason, ensure Merlin takes precedence:
let g:deoplete#sources.ocaml = ['omni', 'buffer']
let g:deoplete#sources.reason = ['omni', 'buffer']
let g:deoplete#omni#input_patterns.ocaml = '.*'
let g:deoplete#omni#input_patterns.reason = '.*'

" Colorizer
nnoremap <leader><F2> :ColorToggle<CR>

" Undotree
nnoremap <F3> :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1

" Sparkup
let g:sparkupExecuteMapping = '<C-e>'       " The default mapping

" Splitjoin (javascript setting)
" see https://github.com/AndrewRadev/splitjoin.vim/issues/67#issuecomment-91582205
let g:splitjoin_javascript_if_clause_curly_braces = 'Sj'

" vim-jsdoc
nnoremap <silent> <C-d> <Plug>(jsdoc)
let g:jsdoc_enable_es6 = 1
let g:jsdoc_tags = {}
let g:jsdoc_tags['param'] = 'arg'
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_return_description = 0
let g:jsdoc_param_description_separator = ' - '

" UltiSnips
let g:UltiSnipsExpandTrigger="<C-g>"
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['personal_snippets']
let g:UltiSnipsSnippetsDir = '~/.vim/personal_snippets'
nnoremap <leader>s :UltiSnipsEdit<CR>

" CtrlSF.vim
let g:ctrlsf_context = '-B 2 -A 2'
let g:ctrlsf_position = 'right'
let g:ctrlsf_winsize = '65%'
let g:ctrlsf_indent = 1
let g:ctrlsf_ignore_dir = ['node_modules', '.git']
nnoremap <C-g> :CtrlSF ""<left>
nmap gr <Plug>CtrlSFCCwordExec
let g:ctrlsf_mapping = {
  \"open"    : ["o", "<CR>"],
  \"openb"   : "O",
  \"split"   : "<C-s>",
  \"vsplit"  : "<C-v>",
  \"tab"     : "<C-t>",
  \"tabb"    : "t",
  \"popen"   : "p",
  \"quit"    : "q",
  \"next"    : "<C-J>",
  \"prev"    : "<C-K>",
  \"pquit"   : "q",
  \"loclist" : "" }

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
inoremap <expr> <C-l> delimitMate#JumpAny()

" VimWiki
let g:vimwiki_ext2syntax = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
                    \  'diary_rel_path': 'journal/', 'diary_index': 'index',
                    \  'diary_header': 'Journal', 'diary_sort': 'asc'}]

let g:EditorConfig_core_mode = 'python_external'    " Speeds up load time by ~150ms

" vim-ragtag
let g:ragtag_global_maps = 1
imap <C-t> <C-x>/
" }}}

" {{{ Key Bindings: Visual mode
"===============================================================================

" Tab modifies indent in visual mode
vnoremap <S-Tab> <<
vnoremap <Tab> >>

" make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" make . and macros work on visual selections (via https://www.reddit.com/r/vim/comments/3y2mgt/)
" Note: the . command must take effect at the start of each line
vnoremap . :norm.<CR>
xnoremap @ :normal @
" }}}

" {{{ Key Bindings: Moving around
"===============================================================================

" (built-in)
" <C-o> - move the cursor position back in the jump list
" <C-i> - move the cursor position forward in the jump list
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
nnoremap <CR> <c-w>w        " more convenient alias
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
autocmd VimResized * wincmd =

" Save current file every time we leave insert mode or leave vim
augroup autoSaveAndRead
    autocmd!
    autocmd InsertLeave,FocusLost * update
    autocmd CursorHold * silent! checktime
augroup END

" <escape> in normal mode also saves
nmap <esc> :w<cr>

" Swap ` and ' for mark jumping:
nnoremap ' `
nnoremap ` '

" Global mark conventions
" Uppercase marks persist between sessions, so they're useful for accessing
" common files quickly. Make the following dotfiles always accessible:
autocmd BufLeave vimrc,init.vim     normal! mV
autocmd BufLeave zshrc              normal! mZ

" Leave a mark behind in the most recently accessed file of certain types.
" via https://www.reddit.com/r/vim/comments/41wgqf/do_you_regularly_use_manual_marks_if_yes_how_do/cz5qfqr
autocmd BufLeave *.css,*.styl       normal! mC
autocmd BufLeave *.styl             normal! mS
autocmd BufLeave *.html,*.mustache  normal! mH
autocmd BufLeave README.md          normal! mR
autocmd BufLeave package.json       normal! mP
autocmd BufLeave *.js,*.jsx         normal! mJ
autocmd BufLeave *.test.js,*.test.jsx   normal! mT

" ProTip: After opening a file with a global mark, you can change vim's cwd to
" the file's location with ":cd %:h"

" Move between errors (using ale)
nnoremap <silent> <C-j> :call ale#loclist_jumping#Jump('after', 1)<CR>
nnoremap <silent> <C-k> :call ale#loclist_jumping#Jump('before', 1)<CR>

" More ale/loclist config
let g:ale_open_list = 1   " Open the loclist when reading a file (if there are errors)
let g:ale_lint_on_text_changed = "normal"
let g:ale_lint_on_insert_leave = 1

" automatically close corresponding loclist when quitting a window
autocmd QuitPre * if &filetype != 'qf' | silent! lclose | endif
" }}}

" {{{ Key Bindings: Misc
"===============================================================================
" Use ':w!!' to save a root-owned file using sudo:
cnoremap w!! w !sudo tee % >/dev/null

cnoremap <C-j> <down>
cnoremap <C-k> <up>

" Make n/N always go in consistent directions:
noremap <silent> n /<CR>
noremap <silent> N ?<CR>

" console.log convenience mapping. Inserts a console.log() call with the variable under the cursor
autocmd FileType javascript nnoremap <Leader>cl yiwoconsole.log(`<c-r>": ${<c-r>"}`)<Esc>hh

" copy/paste with system clipboard:
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

" Resize window with arrow keys
nnoremap <Left> :vertical resize -4<CR>
nnoremap <Right> :vertical resize +4<CR>
nnoremap <Up> :resize -4<CR>
nnoremap <Down> :resize +4<CR>

" Home row left/right bindings for command mode:
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" Treat Ctrl-C like <Esc>, to prevent weird Neovim plugin errors
inoremap <C-c> <Esc>
" }}}

" {{{ Folding
"===============================================================================
set foldlevelstart=10
set foldmethod=syntax
autocmd FileType vim set foldmethod=marker
set pastetoggle=<F2>   " Have had problems with <F2>, see http://stackoverflow.com/q/7885198/351433
" }}}

" {{{ Filetype-specific settings
"===============================================================================
" filetype detection for syntax highlighting
autocmd BufNewFile,BufRead *.md set filetype=markdown
autocmd BufNewFile,BufRead *.mustache set filetype=mustache
autocmd FileType mustache set ft=html.mustache

" sql
" see https://www.reddit.com/r/vim/comments/2om1ib/how_to_disable_sql_dynamic_completion/
let g:omni_sql_no_default_maps = 1

" html
iabbrev target="_blank" target="_blank" rel="noopener"

" CSS-like autocomplete for preprocessor files:
autocmd FileType css,sass,scss,stylus,less set omnifunc=csscomplete#CompleteCSS

" JSX
autocmd BufNewFile,BufRead *.jsx set filetype=jsx
autocmd FileType jsx set ft=javascript.jsx

" JSON files
let g:vim_json_syntax_conceal = 0
autocmd BufRead,BufNewFile *.json set filetype=json

" Vim files (use K to look up the current word in vim's help files)
autocmd FileType vim setlocal keywordprg=:help

" Reason
" There are a bunch of <localleader> bindings that are handy (eg \t), and gd to
" jump to a variable's definition (:MerlinLocate)
" For more on Merlin and vim, see:
"   https://github.com/ocaml/merlin/wiki/vim-from-scratch
"   https://github.com/ocaml/merlin/blob/master/vim/merlin/doc/merlin.txt
autocmd FileType reason map <LocalLeader>f :ReasonPrettyPrint<CR>
let g:ale_linter_aliases = {'reason': 'ocaml'}
" }}}


" Load any machine-specific config from another file, if it exists
try
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry
