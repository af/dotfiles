set encoding=utf-8
scriptencoding utf-8

" For nvim-tree, disable netrw
let loaded_netrw=1
let loaded_netrwPlugin=1

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

" Semi-official plugins
Plug 'neovim/nvim-lspconfig',       { 'commit': '3a7387a' }
Plug 'nvim-treesitter/nvim-treesitter', { 'commit': '684eeac', 'do': ':TSUpdate' }

" Essentials
Plug 'echasnovski/mini.nvim',       { 'tag': 'v0.16.0' }
Plug 'dyng/ctrlsf.vim',             { 'commit': '32236a8' }
Plug 'nvim-tree/nvim-tree.lua',     { 'tag': 'nvim-tree-v1.3.3' }

Plug 'supermaven-inc/supermaven-nvim'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'

" completion and snippets
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'
Plug 'onsails/lspkind.nvim' " for completion type icons

" tpope appreciation section
Plug 'tpope/vim-apathy'
Plug 'tpope/vim-repeat',            { 'commit': '24afe92' }
Plug 'tpope/vim-fugitive',          { 'commit': '5f0d280' }
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sleuth',            { 'commit': '039e2cd' }

" language-specific plugins
" usage-> :MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' }
Plug 'folke/neodev.nvim'

" Misc
Plug 'vimwiki/vimwiki',             { 'commit': '417490f' }
Plug 'bfredl/nvim-miniyank',        { 'commit': '2a3a0f3' }

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
set numberwidth=3           " line number width
set ruler                   " line numbers at bottom of page
set showcmd
set title
set wildmenu
set wildignore=.svn,.git,.gitignore,*.pyc,*.so,*.swp,*.jpg,*.png,*.gif,node_modules,_site,_build,esy.lock
set laststatus=2            " Always show a status line for lowest window in a split
set cursorline              " highlight the full line that the cursor is currently on
set background=dark
set synmaxcol=400           " Performance improvement on large single-line files
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

" Keep cursor centered while searching (and joining)
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

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

  lua require('init')
elseif $TERM ==# 'xterm-256color' || $TERM ==# 'screen-256color'
  set t_Co=256    " 256 colours for regular vim if the terminal can handle it.
  let g:nvcode_termcolors=256
endif

" }}}
" {{{ Completion
"===============================================================================

" completion with nvim-cmp
set completeopt=menu,menuone,noselect

imap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
imap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

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
let g:ctrlsf_indent = 2
let g:ctrlsf_default_root = 'project'
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
" {{{ tree
"===============================================================================

nnoremap - :NvimTreeFindFile<CR>

" }}}
" {{{ More plugin customization
"===============================================================================

" fugitive
nnoremap gs :Git<CR>
"nnoremap gl :Git log<CR>
nnoremap gb :Git blame<CR>

" barbar
nnoremap <silent> <Tab> <Cmd>BufferNext<CR>
nnoremap <silent> <S-Tab> <Cmd>BufferPrevious<CR>
nnoremap <silent> s <Cmd>BufferPick<CR>

" nvim-miniyank (lighter-weight YankRing workalike)
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

" moving selected lines around in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

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
vnoremap <leader>y "+y
nnoremap Y yy

" normal mode: yank path of current buffer into system clipboard
nnoremap <leader>y :let @+ = expand("%")<CR>

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
set foldlevel=99
set foldmethod=syntax
autocmd vimrc FileType vim set foldmethod=marker

" }}}
" {{{ Filetype-specific settings
"===============================================================================
autocmd vimrc BufNewFile,BufRead *.md set filetype=markdown
autocmd vimrc BufNewFile,BufRead *.mdx set filetype=markdown
autocmd vimrc BufNewFile,BufRead *.gql set filetype=graphql

" html
iabbrev target="_blank" target="_blank" rel="noopener"

" Hack to open help in vsplit by default
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

autocmd vimrc FileType gitcommit set tabstop=4
" }}}

nmap <leader>x :source %<CR>

" Load any machine-specific config from another file, if it exists
try
  source ~/.vimrc_machine_specific
catch
  " No such file? No problem; just ignore it.
endtry
