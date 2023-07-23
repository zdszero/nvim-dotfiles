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
nnoremap <c-m> <c-o>
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
" SOME CUSTOM KEYMAPS
"

fun! s:visual_star_search(cmdtype, ...)
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
endfun

xnoremap * :<C-u>call <SID>visual_star_search('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>visual_star_search('?')<CR>?<C-R>=@/<CR><CR>

fun! s:last_edit_file()
  let v:errmsg = ''
  silent! normal 
  if v:errmsg == ''
    return
  endif
  bprevious
endfun

nnoremap [f <cmd> call <SID>last_edit_file()<cr>
nnoremap ]f <cmd> call <SID>last_edit_file()<cr>


nnoremap ]t <cmd>BufferLineMoveNext<CR>
nnoremap [t <cmd>BufferLineMovePrev<CR>
nnoremap ]b <cmd>BufferLineCycleNext<CR>
nnoremap [b <cmd>BufferLineCyclePrev<CR>

fun! s:delete_buffer()
  if &modified
    bd!
    return
  endif
  let bufnum = bufnr()
  BufferLineCyclePrev
  exe 'bdelete ' .. bufnum
endfun

command! BD call <SID>delete_buffer()
nmap <silent> <leader>d :call <SID>delete_buffer()<CR>
nmap <silent> <c-t> :FloatermToggle<CR>
tmap <silent> <c-t> <Esc>:FloatermToggle<CR>

fun! s:format_to_oneline() range
  let merge_line = ''
  for lnum in range(a:firstline, a:lastline)
    let curline = getline(lnum)
    if curline =~# '-$'
      let curline = curline[:-2]
    endif
    if lnum > a:firstline
      let merge_line = merge_line
    endif
    let merge_line = merge_line .. curline
  endfor
  let cmd_range = a:firstline .. ',' .. a:lastline
  exe cmd_range .. 'd'
  call append(a:firstline-1 > 0 ? a:firstline-1 : 0, merge_line)
endfun

xmap <silent> gQ :call <SID>format_to_oneline()<CR>


if !has("nvim")
  nnoremap ]b :bnext<CR>
  nnoremap [b :previous<CR>
  nnoremap ]t :tabnext<CR>
  nnoremap [t :tabNext<CR>
endif
tnoremap <c-[> <C-\><C-N>
tnoremap <esc> <C-\><C-N>
nnoremap [T :tabprevious<CR>
nnoremap ]T :tabnext<CR>

nmap <leader>ts :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>th :TestSuite<CR>
