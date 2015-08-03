" BEGIN VUNDLE CONFIG
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Start of user plugins
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'Townk/vim-autoclose'
Plugin 'vim-scripts/closetag.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-repeat'
Plugin 'mattn/emmet-vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'tpope/vim-unimpaired'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ

" END VUNDLE CONFIG


" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" theme and symbols
let g:airline_powerline_fonts=1
let g:airline_theme = 'wombat'

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
" set clipboard=unnamedplus
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
"set binary
"set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
    set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Session saving/loading on exit/enter
fu! SaveSess()
    execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
    execute 'so ' . getcwd() . '/.session.vim'
    if bufexists(1)
        for l in range(1, bufnr('$'))
            if bufwinnr(l) == -1
                exec 'sbuffer ' . l
            endif
        endfor
    endif
endif
syntax on
endfunction

autocmd VimLeave * NERDTreeClose
autocmd VimLeave * call SaveSess()

autocmd VimEnter * call RestoreSess()
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif


"""""""""""""""""""""""""
" BEGIN PLUGIN SETTINGS "
"""""""""""""""""""""""""
" Set NERDTree's default size
let NERDTreeWinSize=20

" RainbowParentheses
au VimEnter * RainbowParenthesesActivate
function! LoadRainbowParens()
  RainbowParenthesesLoadRound
  RainbowParenthesesLoadSquare
  RainbowParenthesesLoadBraces
endfunction
nnoremap !r :call LoadRainbowParens()<CR>

"au BufNewFile,BufRead * RainbowParenthesesLoadRound
"au BufNewFile,BufRead * RainbowParenthesesLoadSquare
"au BufNewFile,BufRead * RainbowParenthesesLoadBraces

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!|wincmd p
nnoremap \ :Ag<SPACE>

"""""""""""""""""""""""""""
" BEGIN PERSONAL MAPPINGS "
"""""""""""""""""""""""""""
" Change mapleader
let mapleader=","

" Source .vimrc
nnoremap <Leader>sv :source ~/.vimrc<CR>

" Single insert
nmap <space> i_<esc>r

" Delete to black hole
nnoremap R "_d

" Switch windows w/ one key
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Save and close tab
nnoremap ZA :wa<CR>:tabc<CR>

" New tab
"nnoremap <C-t> :tabnew<CR>

" Removing directional keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" Inserting double lines below/above
nnoremap <Leader>j o<CR>
nnoremap <Leader>k O<Esc>O

" Increase/decrease window size
nnoremap + :resize +5<CR>
nnoremap - :resize -5<CR>

" Insert markdown fenced code block
function! FencedCodeBlock()
   normal! i``````k
   startinsert!
endfunction
nnoremap <leader>c :call FencedCodeBlock()<CR>

" Add semicolon to end of line
function! AppendSemicolon()
  normal! mpA;`p
endfunction
nnoremap <leader>sc :call AppendSemicolon()<CR>

" grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>