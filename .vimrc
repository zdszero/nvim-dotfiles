""""""""""""""""""""""""""""""""""
"             OPTIONS            "
""""""""""""""""""""""""""""""""""
set nocompatible
syntax on
filetype plugin indent on
set encoding=utf8

" always open the signcolumn
set signcolumn=number

" expand tab to spaces
set expandtab
set softtabstop=2
set tabstop=2
" set backspace=indent,eol,start	"use backspace to delete indent and line
set shiftwidth=2

set autoindent smartindent
set laststatus=2
set noshowmode

" mouse enable
" set mouse-=a
set mouse=n

" change cursor for different modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set number
set relativenumber
set nocursorline
set nocursorcolumn
" set gcr=a:block

set showcmd
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
set undofile
set history=1000 
set nolist
" true color support

""""""""""""""""""""""""""""""""""
"             MAPPINGS           "
""""""""""""""""""""""""""""""""""

let mapleader=" "

" abbrevations
iabbrev rt return
iabbrev ,a &&
iabbrev ,o \|\|
iabbrev ,e ==
iabbrev ,n !=
iabbrev ,g >=
iabbrev ,l <=

function! s:open_in_browser()
  let l:url = expand('<cWORD>')
  silent! execute '!google-chrome-stable -app ' . l:url
endfunction

nnoremap <silent> <leader>o <cmd>call <SID>open_in_browser()<cr>
inoremap <c-s-cr> <cr><up>

function! s:one_paragraph() range
  let l:endline = a:lastline - 1
  execute a:firstline . ',' . l:endline . 's/\n/ /g'
  silent! execute a:firstline . 's/- //g'
endfunction

xmap <silent> gp :<c-u>call <SID>one_paragraph()<cr>

function! s:visualStarSearch(cmdtype, ...)
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
  let @/ = substitute(@/, '\.', '\\.', 'g')
  let @" = temp
endfunction

xnoremap * :<C-u>call <SID>visualStarSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>visualStarSearch('?')<CR>?<C-R>=@/<CR><CR>

" use control to replace shift
" normal and visual
noremap <c-h> g0
noremap <c-l> g$
noremap j gj
noremap k gk
noremap <c-j> 7gj
noremap <c-k> 7gk
noremap <c-g> G
" operator pending
onoremap <c-h> 0
onoremap <c-l> $
" normal
nnoremap <c-s> :w<cr>
nnoremap <c-q> <c-v>
" simulate uppercase command
nnoremap <c-a> A
noremap <c-i> I
noremap <c-o> O
nnoremap <c-p> P
nnoremap <c-v> V
nnoremap <c-e> E
nnoremap <c-y> yy
nnoremap <c-,> <<
nnoremap <c-.> >>
vnoremap <c-,> <
vnoremap <c-.> >
nnoremap <c-/> /\v
" use <c-m> <c-n> to jump forward and backwoard
nnoremap <c-m> <c-o>
nnoremap <c-n> <c-i>
" insert
inoremap <c-l> <esc>
" emacs like key bindings
inoremap <c-j> <Right>
inoremap <c-k> <Left>
inoremap <c-a> <c-c>I
inoremap <c-e> <c-c>A
inoremap <c-q> <c-c>gUawea
xmap <c-s> S

" copy and paste
nnoremap V "+p
xnoremap C "+y

" alphabet
nnoremap U gUiw
nnoremap R :source $MYVIMRC<CR>
nnoremap Q :q<CR>	
nnoremap <leader>q :q!<CR>
nnoremap <leader><CR> :nohlsearch<CR>

" resize
nnoremap <up> :res +5<CR>
nnoremap <down> :res -5<CR>
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>

" file navigation
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" window navigation
nnoremap <leader>j <c-w>h
nnoremap <leader>k <c-w>j
nnoremap <leader>l <c-w>k
nnoremap <leader>; <c-w>l
nnoremap <leader>h <c-w>J
nnoremap <leader>v <c-w>H

""""""""""""""""""""""""""""""""""
"             COMMANDS           "
""""""""""""""""""""""""""""""""""

augroup TabOptions
   autocmd!
   autocmd FileType asm,python,sql,go setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
augroup END

augroup RunFile
  autocmd!
  autocmd FileType python nmap <leader>rr :!python %<CR>
  autocmd FileType c      nmap <leader>rr :!gcc %<CR>
  autocmd FileType cpp    nmap <leader>rr :!clang++ %<CR>
augroup END

""""""""""""""""""""""""""""""""""
"             PLUGINS            "
""""""""""""""""""""""""""""""""""

if !filereadable(expand('~/.vim/autoload/plug.vim'))
  finish
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'gcmt/wildfire.vim'
Plug 'rakr/vim-one'
Plug 'Raimondi/delimitMate'
call plug#end()

let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

map ge <Plug>(wildfire-fuel)

set background=light
let g:one_allow_italics = 1
color one
