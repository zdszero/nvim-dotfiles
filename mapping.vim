let mapleader=" "

"
" ABBREVATIONS
"
iabbrev rt return
iabbrev ,a &&
iabbrev ,o \|\|
iabbrev ,e ==
iabbrev ,n !=
iabbrev ,g >=
iabbrev ,l <=

"
" POWER CTRL KEY
"

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
noremap <tab> I
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
nnoremap <cr> <c-o>
nnoremap <c-n> <c-i>
" insert
inoremap <c-l> <esc>
inoremap <c-f> <Right>
inoremap <c-b> <Left>
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

"
" TERMINAL
"
tnoremap <c-[> <C-\><C-N>
tnoremap <esc> <C-\><C-N>
" tnoremap <silent> <c-t> <C-\><C-N>:FloatermToggle<cr>
" nnoremap <silent> <c-t> :FloatermToggle<cr>

"
" SOME CUSTOM KEYMAPS
"

function! s:convert_vscode_snippet() range
  let l:before_lastline = a:lastline - 1
  silent! exe a:firstline . ',' . a:lastline . 's/^\s*//g'
  silent! exe a:firstline . ',' . l:before_lastline . 's/\v"(.*)",/\1/g'
  silent! exe a:lastline . 's/\v"(.*)"/\1/g'
  silent! exe a:firstline . ',' . a:lastline . 's/\\t/	/g'
  silent! exe a:firstline . ',' . a:lastline . 's/\\"/"/g'
endfunction

vnoremap <leader>cs :call <SID>convert_vscode_snippet()<CR>

function! s:visual_star_search(cmdtype, ...)
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

xnoremap * :<C-u>call <SID>visual_star_search('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>visual_star_search('?')<CR>?<C-R>=@/<CR><CR>

function! s:last_edit_file()
  let v:errmsg = ''
  silent! normal 
  if v:errmsg == ''
    return
  endif
  bprevious
endfunction

nnoremap [f <cmd> call <SID>last_edit_file()<cr>
nnoremap ]f <cmd> call <SID>last_edit_file()<cr>

nnoremap ]b :bnext<CR>
nnoremap [b :bnext<CR>
nnoremap ]t :tabnext<CR>
nnoremap [t :tabNext<CR>

function! s:open_terminal()
  vsp
  normal! l
  exe 'terminal'
  exe 'vertical resize-10'
endfunction

nmap <leader>t :call <SID>open_terminal()<CR>
