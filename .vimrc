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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'Townk/vim-autoclose'
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
Plugin 'kchmck/vim-coffee-script'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'wavded/vim-stylus'
Plugin 'tpope/vim-ragtag'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'geekjuice/vim-mocha'
Plugin 'vim-scripts/text-object-left-and-right'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'justinmk/vim-gtfo'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kshenoy/vim-signature'
Plugin 'vim-scripts/Mark--Karkat'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-liquid'
Plugin 'elixir-lang/vim-elixir'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-easymotion.vim'
Plugin 'tpope/vim-abolish'
Plugin 'kana/vim-fakeclip'
Plugin 'sjl/gundo.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'tomlion/vim-solidity'

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

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" theme and symbols
let g:airline_powerline_fonts=1
let g:airline_theme = 'wombat'

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
"set clipboard=unnamedplus
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
" Use hybrid line numbers
if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
endif
set number
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Reduce updatetime for quicker gitgutter updating (default 4000)
set updatetime=250
" Change mapleader
let mapleader=","

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

"autocmd VimLeave * NERDTreeClose
"autocmd VimLeave * call SaveSess()

"autocmd VimEnter * call RestoreSess()
autocmd VimEnter * AirlineRefresh

" Automatic commands
if has("autocmd")
    " Enable file type detection
    filetype on
    " Make help files easy to close
    autocmd Filetype help nnoremap <buffer> q :q<CR>
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    autocmd BufNewFile,BufRead *.js setfiletype js
    " Fix tab width for TypeScript files
    autocmd Filetype typescript setlocal ts=4 sw=4 sts=4
    " Fix tab width for Solidity files
    autocmd Filetype solidity setlocal ts=4 sw=4 sts=4
    " Treat .html files as HTML
    autocmd BufNewFile,BufRead *.html setfiletype html
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
    " Treat .ni files as Inform 7
    autocmd BufNewFile,BufRead *.ni setlocal filetype=inform7
    autocmd Filetype inform7 setlocal ts=2 sw=2 sts=2 noexpandtab
    autocmd Filetype inform7 setlocal commentstring=[%s]
    autocmd Filetype inform7 setlocal autoindent smartindent
    " Treat .snippets files as UltiSnips
    autocmd BufNewFile,BufRead *.snippets setlocal filetype=snippets
    " Treat all Starbound modding files as JSON
    autocmd BufNewFile,BufRead *.achievement setlocal filetype=json
    autocmd BufNewFile,BufRead *.activeitem setlocal filetype=json
    autocmd BufNewFile,BufRead *.aimission setlocal filetype=json
    autocmd BufNewFile,BufRead *.animation setlocal filetype=json
    autocmd BufNewFile,BufRead *.ase setlocal filetype=json
    autocmd BufNewFile,BufRead *.augment setlocal filetype=json
    autocmd BufNewFile,BufRead *.back setlocal filetype=json
    autocmd BufNewFile,BufRead *.beamaxe setlocal filetype=json
    autocmd BufNewFile,BufRead *.behavior setlocal filetype=json
    autocmd BufNewFile,BufRead *.biome setlocal filetype=json
    autocmd BufNewFile,BufRead *.bossability setlocal filetype=json
    autocmd BufNewFile,BufRead *.bush setlocal filetype=json
    autocmd BufNewFile,BufRead *.chest setlocal filetype=json
    autocmd BufNewFile,BufRead *.cinematic setlocal filetype=json
    autocmd BufNewFile,BufRead *.codex setlocal filetype=json
    autocmd BufNewFile,BufRead *.collection setlocal filetype=json
    autocmd BufNewFile,BufRead *.combofinisher setlocal filetype=json
    autocmd BufNewFile,BufRead *.config setlocal filetype=json
    autocmd BufNewFile,BufRead *.configfunctions setlocal filetype=json
    autocmd BufNewFile,BufRead *.consumable setlocal filetype=json
    autocmd BufNewFile,BufRead *.currency setlocal filetype=json
    autocmd BufNewFile,BufRead *.cursor setlocal filetype=json
    autocmd BufNewFile,BufRead *.damage setlocal filetype=json
    autocmd BufNewFile,BufRead *.dance setlocal filetype=json
    autocmd BufNewFile,BufRead *.disabled setlocal filetype=json
    autocmd BufNewFile,BufRead *.dungeon setlocal filetype=json
    autocmd BufNewFile,BufRead *.effectsource setlocal filetype=json
    autocmd BufNewFile,BufRead *.event setlocal filetype=json
    autocmd BufNewFile,BufRead *.flashlight setlocal filetype=json
    autocmd BufNewFile,BufRead *.frames setlocal filetype=json
    autocmd BufNewFile,BufRead *.functions setlocal filetype=json
    autocmd BufNewFile,BufRead *.grass setlocal filetype=json
    autocmd BufNewFile,BufRead *.harvestingtool setlocal filetype=json
    autocmd BufNewFile,BufRead *.head setlocal filetype=json
    autocmd BufNewFile,BufRead *.inspectiontool setlocal filetype=json
    autocmd BufNewFile,BufRead *.instrument setlocal filetype=json
    autocmd BufNewFile,BufRead *.item setlocal filetype=json
    autocmd BufNewFile,BufRead *.itemdescription setlocal filetype=json
    autocmd BufNewFile,BufRead *.legs setlocal filetype=json
    autocmd BufNewFile,BufRead *.liqitem setlocal filetype=json
    autocmd BufNewFile,BufRead *.liquid setlocal filetype=json
    autocmd BufNewFile,BufRead *.material setlocal filetype=json
    autocmd BufNewFile,BufRead *.matitem setlocal filetype=json
    autocmd BufNewFile,BufRead *.matmod setlocal filetype=json
    autocmd BufNewFile,BufRead *.miningtool setlocal filetype=json
    autocmd BufNewFile,BufRead *.modularfoliage setlocal filetype=json
    autocmd BufNewFile,BufRead *.modularstem setlocal filetype=json
    autocmd BufNewFile,BufRead *.monstercolors setlocal filetype=json
    autocmd BufNewFile,BufRead *.monsterpart setlocal filetype=json
    autocmd BufNewFile,BufRead *.monsterskill setlocal filetype=json
    autocmd BufNewFile,BufRead *.monstertype setlocal filetype=json
    autocmd BufNewFile,BufRead *.namesource setlocal filetype=json
    autocmd BufNewFile,BufRead *.npctype setlocal filetype=json
    autocmd BufNewFile,BufRead *.object setlocal filetype=json
    autocmd BufNewFile,BufRead *.objectdisabled setlocal filetype=json
    autocmd BufNewFile,BufRead *.painttool setlocal filetype=json
    autocmd BufNewFile,BufRead *.parallax setlocal filetype=json
    autocmd BufNewFile,BufRead *.particle setlocal filetype=json
    autocmd BufNewFile,BufRead *.particlesource setlocal filetype=json
    autocmd BufNewFile,BufRead *.partparams setlocal filetype=json
    autocmd BufNewFile,BufRead *.projectile setlocal filetype=json
    autocmd BufNewFile,BufRead *.questtemplate setlocal filetype=json
    autocmd BufNewFile,BufRead *.radiomessages setlocal filetype=json
    autocmd BufNewFile,BufRead *.recipe setlocal filetype=json
    autocmd BufNewFile,BufRead *.ridgeblocks setlocal filetype=json
    autocmd BufNewFile,BufRead *.spawntypes setlocal filetype=json
    autocmd BufNewFile,BufRead *.species setlocal filetype=json
    autocmd BufNewFile,BufRead *.stagehand setlocal filetype=json
    autocmd BufNewFile,BufRead *.statuseffect setlocal filetype=json
    autocmd BufNewFile,BufRead *.structure setlocal filetype=json
    autocmd BufNewFile,BufRead *.tech setlocal filetype=json
    autocmd BufNewFile,BufRead *.tenant setlocal filetype=json
    autocmd BufNewFile,BufRead *.terrain setlocal filetype=json
    autocmd BufNewFile,BufRead *.thrownitem setlocal filetype=json
    autocmd BufNewFile,BufRead *.tillingtool setlocal filetype=json
    autocmd BufNewFile,BufRead *.tooltip setlocal filetype=json
    autocmd BufNewFile,BufRead *.treasurechests setlocal filetype=json
    autocmd BufNewFile,BufRead *.treasurepools setlocal filetype=json
    autocmd BufNewFile,BufRead *.unlock setlocal filetype=json
    autocmd BufNewFile,BufRead *.vehicle setlocal filetype=json
    autocmd BufNewFile,BufRead *.weaponability setlocal filetype=json
    autocmd BufNewFile,BufRead *.weaponcolors setlocal filetype=json
    autocmd BufNewFile,BufRead *.weather setlocal filetype=json
    autocmd BufNewFile,BufRead *.wiretoolset setlocal filetype=json
endif

" Code folding "
autocmd BufNewFile,BufReadPost *.coffee setl foldmethod=indent foldlevel=1 nofoldenable
autocmd BufNewFile,BufReadPost *.html setl foldmethod=indent foldlevel=0 nofoldenable

"""""""""""""""""""""""""
" BEGIN PLUGIN SETTINGS "
"""""""""""""""""""""""""
" Fix brblack solarized color issue
let g:solarized_termtrans = 1
" Use the Solarized Dark theme
set background=dark
colorscheme solarized

" fix git gutter highlighting after applying colorscheme
call gitgutter#highlight#define_highlights()

" airline settings
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#format = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" airline truncation widths
let g:airline#extensions#default#section_truncate_width = {
  \ 'b': 45,
  \ 'x': 100,
  \ 'y': 100,
  \ 'z': 85,
  \ 'warning': 80,
  \ 'error': 80,
  \ }

" Set NERDTree's default size
let NERDTreeWinSize=20
" Ignore .js files in NERDTree
"let NERDTreeIgnore=['\.js$']
" NERDTree toggle hotkey
nmap <Tab><Tab> :NERDTreeToggle<CR>
" reveal the current file in NERDTree
map <Leader>f :NERDTreeFind<CR>

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
  " (in git repos ignore)
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --ignore "*.js"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" replace current window's buffer when opening multiple files
let g:ctrlp_open_multiple_files = 'vr'
" abbreviation to change search directory to current file
let g:ctrlp_abbrev = {
  \ 'abbrevs': [
    \ {
      \ 'pattern': '%',
      \ 'expanded': '@cd %:h'
    \ }
  \ ]
\ }

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!|wincmd p
nnoremap \ :Ag<SPACE>

" indent guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=10 "base01
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=0 "base02

" change emmet trigger key to C-X to match ragtag
let g:user_emmet_leader_key='<C-X>'
let g:ragtag_global_maps = 1

" highlight marks in gutter by gitgutter status
let g:SignatureMarkTextHLDynamic = 1
let g:SignatureMarkerTextHLDynamic = 1

" Marks highlighting palette
:hi MarkWord1  ctermbg=DarkGreen    ctermfg=Black
:hi MarkWord2  ctermbg=DarkCyan     ctermfg=Black
:hi MarkWord3  ctermbg=DarkBlue     ctermfg=Black
:hi MarkWord4  ctermbg=DarkMagenta  ctermfg=Black
:hi MarkWord5  ctermbg=DarkRed      ctermfg=Black
:hi MarkWord6  ctermbg=DarkYellow   ctermfg=Black

" UltiSnips keys
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<tab>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"

" easymotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case insensitive feature

" incsearch config
let g:incsearch#separate_highlight = 1
let g:incsearch#auto_nohlsearch = 1

" syntastic -- linting
let g:syntastic_warning_symbol = "->"
"let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_coffee_coffeelint_args = "-f ~/coffeelint.json"
let g:syntastic_coffee_coffeelint_args = "-f ~/coffeelint.json"
let g:syntastic_html_tidy_args = "--show-warnings false"

" fakeclip config
let g:fakeclip_provide_clipboard_key_mappings = 1

"""""""""""""""""""""""""""
" BEGIN PERSONAL MAPPINGS "
"""""""""""""""""""""""""""
" Source .vimrc
nnoremap <Leader>sv :source ~/.vimrc<CR>

" Redraw the screen
nnoremap !! :redraw!<CR>

" Single insert
nmap <space> i_<esc>r

" Delete to black hole
nnoremap R "_d
vnoremap R "_d

" Switch windows w/ one key
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Move windows without switching modifier keys
nnoremap <C-w><C-h> <C-w>H
nnoremap <C-w><C-j> <C-w>J
nnoremap <C-w><C-k> <C-w>K
nnoremap <C-w><C-l> <C-w>L

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
"nnoremap + :resize +5<CR>
"nnoremap - :resize -5<CR>

" Insert markdown fenced code block
"function! FencedCodeBlock()
   "normal! i```
```k
   "startinsert!
"endfunction
"nnoremap <leader>c :call FencedCodeBlock()<CR>

" compile coffescript selection or entire file
vnoremap <leader>co :CoffeeCompile<CR>
nnoremap <leader>co :CoffeeCompile<CR>

" vim-mocha keys
noremap <Leader>t :call RunCurrentSpecFile()<CR>
noremap <Leader>s :call RunNearestSpec()<CR>
noremap <Leader>l :call RunLastSpec()<CR>
noremap <Leader>a :call RunAllSpecs()<CR>

" Add semicolon to end of line
function! AppendSemicolon()
  normal! mpA;`pdmp
endfunction
nnoremap <leader>sc :call AppendSemicolon()<CR>

" grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" visual shifting
vnoremap < <gv
vnoremap > >gv

" fugitive -- command line tools in vim
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gp :Gpush<CR>
nnoremap <silent> <leader>ge :Gedit<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>

" fugitive -- getting info on files
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>go :Gbrowse<CR>
vnoremap <silent> <leader>go :Gbrowse<CR>

" fugitive -- looking at diffs:
" [D]iff current file, [R]eview working changes, and [F]inal staged changes
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gr :Gvsplit! diff<CR>
nnoremap <silent> <leader>gf :Gvsplit! diff --staged<CR>

" fugitive -- diff helpers for staging single lines
nnoremap <silent> <leader>dp V:diffput<CR>:diffupdate<CR>
vnoremap <silent> <leader>dp :diffput<CR>:diffupdate<CR>
nnoremap <silent> <leader>do V:diffget<CR>:diffupdate<CR>
vnoremap <silent> <leader>do :diffget<CR>:diffupdate<CR>
nnoremap <silent> <leader>du :diffupdate<CR>

" edit ulti snippets
nnoremap <silent> <leader>u :UltiSnipsEdit<CR>

" beautify code
" fallback to JSON for pasted snippets
noremap <c-b> :call JsonBeautify()<cr>
vnoremap <c-b> :call RangeJsonBeautify()<cr>
" filetype specific commands for beautifying entire file
autocmd FileType javascript noremap <buffer>  <c-b> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-b> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-b> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-b> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-b> :call CSSBeautify()<cr>
" filetype specific commands for beautifying selection
autocmd FileType javascript vnoremap <buffer>  <c-b> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <c-b> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <c-b> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <c-b> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <c-b> :call RangeCSSBeautify()<cr>

" jump between highlight marks
" (toggle current word with <leader>m)
" (toggle mark visibility with <leader>n)
" remove all marks:
nnoremap <leader><leader>n :MarkClear<CR>
" jump to next instance of mark under cursor or last mark: <leader>*
" jump to next instance of any mark: <leader>/
" when over mark, do * to repeat most recently used of these last two above

" incsearch -- replace normal search
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
" incsearch + easymotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

" easymotion anywhere -- `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)

" easymotion linewise
nmap <leader><leader>j <Plug>(easymotion-j)
nmap <leader><leader>k <Plug>(easymotion-k)

" gundo mappings
nnoremap <leader><leader>u :GundoToggle<CR>
let g:gundo_width = 40
let g:gundo_preview_height = 20
let g:gundo_preview_bottom = 1
"let g:gundo_auto_preview = 0