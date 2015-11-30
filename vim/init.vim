" General Notes
" * see ":h normal-index" or ":h insert-index" for a list of built-in mappings
" * see ":verbose nmap <C-j>" (for example) for maps setup by plugins or .vimrc

set nocompatible            " we're using Vim, not Vi

"===============================================================================
" Plugin setup
"===============================================================================
call plug#begin('~/.vim/plugged')

" vim plugins, managed by vim-plug
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline', { 'commit': 'aef500c426' }
Plug 'tomtom/tcomment_vim', { 'commit': '3d0a9975' }
Plug 'tpope/vim-repeat', { 'commit': '7a6675f09' }  " Enable . repeat for plugin operations (eg. gitgutter)
Plug 'tpope/vim-surround', { 'commit': '42e9b46e' }
Plug 'jeetsukumaran/vim-filebeagle', { 'commit': 'abfb7f9d2' }
Plug 'tommcdo/vim-exchange', { 'commit': 'b82a774' }
Plug 'AndrewRadev/splitjoin.vim', { 'commit': '4b062a' } " gS and gJ to split/join lines
Plug 'sheerun/vim-polyglot', { 'commit': '1c21231' }     " syntax highlighting for many languages
Plug 'vimwiki/vimwiki', { 'commit': '2c03d8' }
Plug 'justinmk/vim-sneak', { 'commit': '9eb89e43' }
Plug 'af/YankRing.vim', { 'commit': '0e4235b1', 'on': [] }         " using fork, as v18 isn't officially on GH
Plug 'tpope/vim-obsession', { 'commit': '4ab72e07ec' }   " start a session file with :Obsession
Plug 'gabesoft/vim-ags', { 'commit': '182c472' }

" Git/VCS related plugins
Plug 'tpope/vim-fugitive', { 'commit': '935a2ccc' }
Plug 'airblade/vim-gitgutter', { 'commit': '339f8ba0' }

" Indentation, etc. Autodetect, but override with .editorconfig if present:
Plug 'tpope/vim-sleuth', { 'commit': '039e2cd' }
Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' } " TODO: load lazily, w/o input lag

" Javascript and HTML-related plugins
Plug 'moll/vim-node', { 'commit': '07a5e9f91' }      " Lazy loading doesn't work for some reason
Plug 'tristen/vim-sparkup', { 'commit': '1375ce1e7', 'for': 'html' }
Plug 'tpope/vim-ragtag', { 'for': 'html' }

" Ultisnips (private snippets are stored in this repo)
Plug 'UltiSnips', { 'tag': '3.0', 'on': [] }

" theme/syntax related plugins:
Plug 'benekastah/neomake', { 'commit': 'c1de90f' }
Plug 'colorizer', { 'commit': 'aae6b518' }

" Colour schemes:
Plug 'tomasr/molokai', { 'commit': 'e7bcec7573' }        " default
Plug 'morhetz/gruvbox', { 'commit': 'ffe202e4' }         " brown/retro. :set bg=dark
Plug 'whatyouhide/vim-gotham', { 'commit': '6486e10' }

" Cool plugins that are disabled because they add to startup time:
" Plug 'ashisha/image.vim', { 'commit': 'ae15d1c5' }       " view images in vim (requires `pip install Pillow`)

" plugins for colorscheme dev (not tested yet):
" https://github.com/shawncplus/Vim-toCterm
" https://github.com/guns/xterm-color-table.vim

" Try later:
" Plug 'tpope/vim-unimpaired'
" Plug 'zefei/vim-colortuner'
" Plug 'mattn/emmet-vim'
" Plug 'jaxbot/github-issues.vim'          " TODO: configure this

" Tried but disabled for now:
" Plug 'ervandew/supertab', 'c8bfeceb'
" Plug 'Raimondi/delimitMate'       " disabled because of https://github.com/Raimondi/delimitMate/issues/138

" Load some of the more sluggish plugins on first insert mode enter,
" to improve startup time:
augroup load_on_insert
  autocmd!
  autocmd InsertEnter * call plug#load('UltiSnips', 'YankRing.vim') | autocmd! load_on_insert
augroup END

call plug#end()
"===============================================================================
" (End of plugin setup)
"===============================================================================



"===============================================================================
" General Vim settings
"===============================================================================
let mapleader = " "         " <leader> is our personal modifier key
set visualbell
set history=500             " longer command history (default=20)
set backspace=indent,eol,start
set noswapfile              " Disable swap files
"set directory=~/.vim/swp    " where the .swp files go (if enabled)
"set shellpipe=>             " Prevents results from flashing during Ack.vim searches

" File/buffer settings
autocmd BufWinEnter,BufNewFile * silent tabo    " Ensure only one tab is open
set hidden                  " TODO: revisit this. Hides instead of unloads buffers
set autoread                " reload files on changes (ie. changing git branches)
set encoding=utf-8
set scrolloff=3             " # of lines always shown above/below the cursor

" Indenting & white space
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set autoindent
set list listchars=tab:›\ ,trail:·          " mark trailing white space
"set list listchars=tab:›\ ,trail:·,eol:¬   " mark trailing white space (with eol)


"===============================================================================
" Display/window settings
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
set helpheight=99999        " Hack to make help pages open "fullscreen"

" Automatically set quickfix height
" http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(3, 30)       " 2nd arg=> max height
function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

"===============================================================================
" Searching & Replacing
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

"===============================================================================
" Line wrapping
"===============================================================================
set wrap
set textwidth=99
set formatoptions=qrn1
nnoremap j gj
nnoremap k gk

if has('nvim')
    " Neovim True Color support
    " For this to work, need:
    " * a nightly iTerm build
    " * a patched tmux: https://gist.github.com/choppsv1/dd00858d4f7f356ce2cf
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let &t_8b="\e[48;2;%ld;%ld;%ldm"

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
    au WinEnter term://* call feedkeys('i')
endif


"===============================================================================
" Colorscheme
"===============================================================================
color gruvbox
set bg=dark

" MacVim/GVIM and 256-colour term overrides
if has('gui_running')
    set guifont=Monaco:h14      " gvim/mvim: Bump up the default fontsize
elseif $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256            " Richer colours if our terminal can handle it.
endif


" Show syntax highlighting groups for word under cursor with <leader>s
" From Vimcasts #25: http://vimcasts.org/episodes/creating-colorschemes-for-vim/
nnoremap <leader>h :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


"===============================================================================
" Plugin customization
"===============================================================================

" FileBeagle
let g:filebeagle_show_hidden = 1        " Use 'gh' to toggle- FileBeagle hides lots by default

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" Ctrl-P
nnoremap <C-t> :CtrlPBuffer<CR>             " Search active buffers
nnoremap <C-m> :CtrlPMRUFiles<CR>
let g:ctrlp_map = '<leader><leader>'    " Search in current directory
let g:ctrlp_open_new_file = 'r'         " Open files in the current window
let g:ctrlp_open_multiple_files = 'i'   " Open each of multiple files in new hidden buffers
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden --ignore .git --ignore node_modules -g ""'

" gitgutter
nmap <leader>a <Plug>GitGutterStageHunk
nmap <leader>r <Plug>GitGutterRevertHunk
nmap <C-j> :GitGutterNextHunk<CR>
nmap <C-k> :GitGutterPrevHunk<CR>


" Neomake
map <C-e> :lnext<CR>

let g:neomake_open_list = 2
autocmd! BufWritePost,BufWinEnter * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_error_sign = { 'text': '!>', 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'text': '❯❯', 'texthl': 'MyWarningMsg' }

" vim-airline:
" Note: the following symbols require a patched font.
" For Monaco, I used https://github.com/fromonesrc/monaco-powerline-vim
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'
let g:airline_theme = 'murmur'
let g:airline#extensions#tabline#enabled = 1    " Tab line at top of window

" Supertab
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabContextDefaultCompletionType = '<c-n>'
" let g:SuperTabNoCompleteAfter = ['^', ',', ';', '\s']

" Colorizer
nnoremap <leader><F2> :ColorToggle<CR>

" Sparkup
let g:sparkupExecuteMapping = '<C-e>'       " The default mapping

" Splitjoin (javascript setting)
" see https://github.com/AndrewRadev/splitjoin.vim/issues/67#issuecomment-91582205
let g:splitjoin_javascript_if_clause_curly_braces = 'Sj'

" UltiSnips
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['personal_snippets']
let g:UltiSnipsSnippetsDir = '~/.vim/personal_snippets'
nnoremap <leader>s :UltiSnipsEdit<CR>

" Ags.vim
nnoremap <C-g> :Ags 
autocmd FileType agsv nnoremap <C-o> :call AgsOpenItemCloseResults()<CR>
let g:ags_agcontext = 1     " Show one line above and below the match

" Hack to open the current result and close the results window in one keystroke:
autocmd FileType agsv nnoremap <C-o> :call AgsOpenItemCloseResults()<CR>
function! AgsOpenItemCloseResults()
  call ags#openFile(line('.'), 'u', 1)
  call ags#quit()
endfunction

" VimWiki
let g:vimwiki_ext2syntax = {}
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md',
                    \  'diary_rel_path': 'journal/', 'diary_index': 'index',
                    \  'diary_header': 'Journal', 'diary_sort': 'asc'}]


"===============================================================================
" Key Bindings: Indentation levels
"===============================================================================

" Tab indenting in normal & visual modes
" nnoremap <Tab> >>
" nnoremap <S-Tab> <<
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

"===============================================================================
" Key Bindings: Moving around
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
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nnoremap <silent> <C-u> :bd<CR>
nmap <C-q> :1,100bd<CR>

" Easier movement between windows (Neovim only?):
nnoremap <A-j> <c-w>j
nnoremap <A-k> <c-w>k
nnoremap <A-h> <c-w>h
nnoremap <A-l> <c-w>l
vnoremap <A-j> <c-\><c-n><c-w>j
vnoremap <A-k> <c-\><c-n><c-w>k
vnoremap <A-h> <c-\><c-n><c-w>h
vnoremap <A-l> <c-\><c-n><c-w>l
inoremap <A-j> <c-\><c-n><c-w>j
inoremap <A-k> <c-\><c-n><c-w>k
inoremap <A-h> <c-\><c-n><c-w>h
inoremap <A-l> <c-\><c-n><c-w>l
cnoremap <A-j> <c-\><c-n><c-w>j
cnoremap <A-k> <c-\><c-n><c-w>k
cnoremap <A-h> <c-\><c-n><c-w>h
cnoremap <A-l> <c-\><c-n><c-w>l

" Save current file every time we leave insert mode or hit <esc>:
" Note that the autocmd repeats the mapping each time we leave insert mode,
" this doesn't seem to be a problem in practice.
"
" Alternative approaches (which didn't seem to work as well for my needs):
" set autowriteall   (couldn't get this to work)
" :au FocusLost * :wa
" autocmd InsertLeave * if expand('%') != '' | update | endif
" (last one via http://blog.unixphilosopher.com/2015/02/five-weird-vim-tricks.html)
inoremap <esc> <esc>:w<CR>
autocmd InsertLeave * nnoremap <esc> <esc>:w<CR>

" Swap ` and ' for mark jumping:
nnoremap ' `
nnoremap ` '

" Global mark conventions
" Uppercase marks persist between sessions, so they're useful for accessing
" common files quickly. By convention, use the following global marks:
"
" V     - vimrc
" Z     - zshrc
" J     - jshintrc
"
" ProTip: After opening a file with a global mark, you can change vim's cwd to
" the file's location with ":cd %:h"


"===============================================================================
" Key Bindings: Misc
"===============================================================================
" Use ':w!!' to save a root-owned file using sudo:
cmap w!! w !sudo tee % >/dev/null

cnoremap <C-j> <down>
cnoremap <C-k> <up>

set foldlevelstart=10
set pastetoggle=<C-y>   " Had problems with <F2>, see http://stackoverflow.com/q/7885198/351433

" copy/paste with system clipboard:
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P


"===============================================================================
" Filetype-specific settings
"===============================================================================
" filetype detection for syntax highlighting
au BufNewFile,BufRead *.md set filetype=markdown
" Disabled mustache for now, since the polyglot plugin adds ^F when using ragtag:
" au BufNewFile,BufRead *.mustache set filetype=mustache
" autocmd FileType mustache set ft=html.mustache

" JSON files
au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.json setlocal syntax=javascript


"===============================================================================
" Misc
"===============================================================================

" Set vim's cwd to the closest ancestor dir containing a .git directory
" using "git rev-parse --show-toplevel"
function! MoveToGitDir()
  let filePath = fnamemodify(bufname("%"), ':p:h')
  exe 'cd' fnameescape(filePath)
  let repoPath = system("git rev-parse --show-toplevel")
  let repoPath = substitute(repoPath, '\n$', '', '')    " Remove newline from system() output
  exe 'cd' fnameescape(repoPath)
  echo 'Changed dir to ' . repoPath
endfunc
nnoremap <leader>d :call MoveToGitDir()<CR>
