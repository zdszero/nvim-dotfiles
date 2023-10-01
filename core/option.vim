set nocompatible
syntax on
filetype plugin indent on
set encoding=utf8

" always open the signcolumn
set signcolumn=yes

" expand tab to spaces
set expandtab
set softtabstop=2
set tabstop=2
" set backspace=indent,eol,start	"use backspace to delete indent and line
set shiftwidth=2

set autoindent smartindent
if has("nvim-0.7")
  set laststatus=3
else
  set laststatus=2
endif
set noshowmode

" mouse enable
" set mouse-=a
set mouse=n

" cursor shape
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

set number
set relativenumber
set nocursorline
set nocursorcolumn
" set gcr=a:block

set showcmd
set cmdheight=1
set wildmenu
set wrap
set wrapmargin=0
set scrolloff=5
set ruler

set hlsearch
set incsearch
exec "nohlsearch"
set ignorecase
set smartcase
set magic

set autochdir
set nobackup
if has("vim")
  set undodir=$HOME/.vim/undo
endif
set undofile
set history=1000 
set nolist
" true color support
set termguicolors
set guifont=JetBrains\ Mono\ Medium:h14

let g:sql_type_default = 'mysql'

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldtext=getline(v:foldstart).'...'.trim(getline(v:foldend))
set fillchars=fold:\ 
set foldnestmax=3
set foldminlines=1
set nofoldenable
set t_Co=256

let g:python3_host_prog = '/usr/bin/python3'
