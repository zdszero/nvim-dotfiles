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

function! s:last_edit_file()
  let v:errmsg = ''
  silent! normal 
  if v:errmsg == ''
    return
  endif
  bprevious
endfunction

function! s:BDelete()
  let l:bufnum = bufnr()
  call s:last_edit_file()
  exe 'bdelete ' . l:bufnum
endfunction

" file navigation
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>
nnoremap [f <cmd> call <SID>last_edit_file()<cr>
command! BD call <SID>BDelete()

" window navigation
nnoremap <leader>j <c-w>h
nnoremap <leader>k <c-w>j
nnoremap <leader>l <c-w>k
nnoremap <leader>; <c-w>l
nnoremap <leader>h <c-w>J
nnoremap <leader>v <c-w>H

" terminal
tnoremap <c-[> <C-\><C-N>
tnoremap <esc> <C-\><C-N>
tnoremap <silent> <c-t> <C-\><C-N>:FloatermToggle<cr>
nnoremap <silent> <c-t> :FloatermToggle<cr>
