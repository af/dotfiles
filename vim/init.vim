" General Notes
" * see ":h normal-index" or ":h insert-index" for a list of built-in mappings
" * see ":verbose nmap <C-j>" (for example) for maps setup by plugins or .vimrc
" * profile startup time with "vim --startuptime startup.log"

set nocompatible            " we're using (neo)vim, not Vi

"===============================================================================
" Plugin setup via vim-plug
"
" * Run :PlugInstall to install
" * Run :PlugUpdate to update
"===============================================================================
call plug#begin('~/.vim/plugged')

" vim plugins, managed by vim-plug
Plug 'kien/ctrlp.vim',              { 'commit': 'b5d3fe6' }
Plug 'vim-airline/vim-airline',     { 'commit': '842e562' }
Plug 'vim-airline/vim-airline-themes', { 'commit': '13bad30' }
Plug 'tpope/vim-repeat',            { 'commit': '7a6675f' }     " Enable . repeat for plugin operations (eg. gitgutter)
Plug 'vimwiki/vimwiki',             { 'tag':    'v2.2.1'  }
Plug 'justinmk/vim-sneak',          { 'commit': '9eb89e4' }
Plug 'danro/rename.vim',            { 'commit': 'f133763' }
Plug 'af/YankRing.vim',             { 'commit': '0e4235b', 'on': [] }   " using fork, as v18 isn't officially on GH
Plug 'tpope/vim-obsession',         { 'commit': '4ab72e0' }     " start a session file with :Obsession
Plug 'gabesoft/vim-ags',            { 'commit': '182c472' }
Plug 'junegunn/fzf',                { 'commit': '661d06c', 'dir': '~/.fzf', 'do': './install --all' }
Plug 'jeetsukumaran/vim-filebeagle',{ 'commit': 'abfb7f9' }
Plug 'junegunn/vim-xmark',          { 'commit': '6dd673a', 'do': 'make', 'for': 'markdown' }
Plug 'mbbill/undotree',             { 'commit': '39e5cf0' }
Plug 'troydm/zoomwintab.vim',       { 'commit': 'b7a940e' }
Plug 'wellle/targets.vim',          { 'commit': 'f6f2d66' }

" Editing modifications
Plug 'tommcdo/vim-exchange',        { 'commit': 'b82a774' }
Plug 'AndrewRadev/splitjoin.vim',   { 'commit': '4b062a0' }     " gS and gJ to split/join lines
Plug 'Raimondi/delimitMate',        { 'commit': '8bc47fd' }
Plug 'tpope/vim-surround',          { 'commit': '42e9b46' }
Plug 'tomtom/tcomment_vim',         { 'commit': '3d0a997' }

" Git/VCS related plugins
Plug 'tpope/vim-fugitive',          { 'commit': '935a2cc' }
Plug 'airblade/vim-gitgutter',      { 'commit': '339f8ba' }

" Indentation, etc. Autodetect, but override with .editorconfig if present:
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }
Plug 'editorconfig/editorconfig-vim', { 'commit': '646c180' }   " TODO: load lazily, w/o input lag

" Javascript and HTML-related plugins
Plug 'moll/vim-node',               { 'commit': '13b3121' }     " Lazy loading doesn't work for some reason
Plug 'tristen/vim-sparkup',         { 'commit': '1375ce1', 'for': 'html' }
Plug 'tpope/vim-ragtag',            { 'commit': '0ef3f6a', 'for': ['html', 'xml'] }

" theme/syntax related plugins:
Plug 'sheerun/vim-polyglot',        { 'commit': '1c21231' }     " syntax highlighting for many languages
Plug 'benekastah/neomake',          { 'commit': 'c1de90f' }
Plug 'colorizer',                   { 'commit': 'aae6b51', 'on': 'ColorToggle' }

" Colour schemes:
Plug 'morhetz/gruvbox',             { 'commit': 'e4ba7ab' }     " default. brown/retro. :set bg=dark
Plug 'tomasr/molokai',              { 'commit': 'e7bcec7' }
Plug 'whatyouhide/vim-gotham',      { 'commit': '6486e10' }

" Ultisnips (private snippets are stored in this dotfiles repo)
Plug 'UltiSnips',                   { 'tag': '3.0', 'on': [] }


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
"set helpheight=99999        " Hack to make help pages open "fullscreen"

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
elseif $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256            " 256 colours for regular vim if the terminal can handle it.
endif


"===============================================================================
" Colorscheme
"===============================================================================
color gruvbox
set bg=dark


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

" FZF
" More tips: https://github.com/junegunn/fzf/wiki/Examples-(vim)
nmap <leader><leader> :FZF<CR>
let g:fzf_action = { 'ctrl-s': 'split', 'ctrl-v': 'vertical split' }

" When launching vim, if no file was provided, launch FZF automatically
function! s:fzf_on_launch()
  if @% == ""
    call fzf#run({'sink': 'e', 'window': 'rightbelow new'})
  endif
endfunction
autocmd VimEnter * call <SID>fzf_on_launch()

command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})
nnoremap <C-m> :FZFMru<CR>


" Ctrl-P
nnoremap <C-t> :CtrlPBuffer<CR>         " Search active buffers
"nnoremap <C-m> :CtrlPMRUFiles<CR>
"let g:ctrlp_map = '<leader><leader>'    " Search in current directory
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
" Disabled for regular vim, since this plugin seems to crash it sometimes
if has('nvim')
    map <C-e> :lnext<CR>
    autocmd! BufWritePost,BufWinEnter * Neomake
    let g:neomake_open_list = 2
    let g:neomake_javascript_enabled_makers = ['eslint']
    let g:neomake_error_sign = { 'text': '!>', 'texthl': 'ErrorMsg' }
    let g:neomake_warning_sign = { 'text': '❯❯', 'texthl': 'MyWarningMsg' }
endif

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

" UltiSnips
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsSnippetDirectories = ['personal_snippets']
let g:UltiSnipsSnippetsDir = '~/.vim/personal_snippets'
nnoremap <leader>s :UltiSnipsEdit<CR>

" Ags.vim
nnoremap <C-g> :Ags 
autocmd FileType agsv nnoremap <C-o> :call AgsOpenItemCloseResults()<CR>
let g:ags_agcontext = 1     " Show one line above and below the match

" delimitMate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
inoremap <expr> <C-l> delimitMate#JumpAny()

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

let g:EditorConfig_core_mode = 'python_external'    " Speeds up load time by ~150ms

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
nnoremap <A-c> <c-w>c
nnoremap <A-s> <c-w>s
nnoremap <A-v> <c-w>v
nnoremap <A-o> <c-w>o
nnoremap <A-z> :ZoomWinTabToggle<CR>
nnoremap <A-p> <c-w>p       " most recently used window
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
" common files quickly. Make the following dotfiles always accessible:
autocmd BufLeave vimrc,init.vim     normal! mV
autocmd BufLeave zshrc              normal! mZ

" Leave a mark behind in the most recently accessed file of certain types.
" via https://www.reddit.com/r/vim/comments/41wgqf/do_you_regularly_use_manual_marks_if_yes_how_do/cz5qfqr
autocmd BufLeave *.css,*.styl       normal! mC
autocmd BufLeave *.html,*.mustache  normal! mH
autocmd BufLeave README.md          normal! mR
autocmd BufLeave package.json       normal! mP
" if a js filename has "test" in it, mark it T. Otherwise J:
autocmd BufLeave *.js
    \ | if (expand("<afile>")) =~ "test.*"
    \ | execute 'normal! mT'
    \ | else
    \ | execute 'normal! mJ'
    \ | endif

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

" vim-ragtag
let g:ragtag_global_maps = 1
imap <C-r> <C-x>/

" Resize window with arrow keys
nnoremap <Left> :vertical resize -4<CR>
nnoremap <Right> :vertical resize +4<CR>
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>

"===============================================================================
" Filetype-specific settings
"===============================================================================
" filetype detection for syntax highlighting
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mustache set filetype=mustache
autocmd FileType mustache set ft=html.mustache

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
