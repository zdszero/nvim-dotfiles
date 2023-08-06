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
nnoremap <leader><CR> :nohlsearch<CR>:call setreg("/", "")<CR>

" resize
nnoremap <up> :res +5<CR>
nnoremap <down> :res -5<CR>
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>

"
" SOME CUSTOM KEYMAPS
"
xnoremap * :<C-u>call <SID>visual_star_search('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>visual_star_search('?')<CR>?<C-R>=@/<CR><CR>

nnoremap [f <cmd> call <SID>last_edit_file()<cr>
nnoremap ]f <cmd> call <SID>last_edit_file()<cr>


nnoremap ]t <Plug>(wintabs_move_right)
nnoremap [t <Plug>(wintabs_move_left)
nnoremap ]b <Plug>(wintabs_next)
nnoremap [b <Plug>(wintabs_previous)

command! BD call <SID>delete_buffer()
nmap <silent> <leader>d :call <SID>delete_buffer()<CR>
nmap <silent> <c-t> :FloatermToggle<CR>
tmap <silent> <c-t> <Esc>:FloatermToggle<CR>

xmap <silent> gQ :call <SID>format_to_oneline()<CR>

tnoremap <c-[> <C-\><C-N>
tnoremap <esc> <C-\><C-N>
nnoremap [T :tabprevious<CR>
nnoremap ]T :tabnext<CR>

nmap <leader>ts :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>th :TestSuite<CR>

nmap <leader>rw :call <SID>rename_visual_selection()<CR>

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

fun! s:last_edit_file()
  let v:errmsg = ''
  silent! normal 
  if v:errmsg == ''
    return
  endif
  bprevious
endfun

fun! s:delete_buffer()
  if &modified
    bd!
    return
  endif
  let bufnum = bufnr()
  exe 'bdelete ' .. bufnum
endfun

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

fun! s:rename_visual_selection()
  if @/ == ""
    let subs = input('rename to: ')
    if subs == ''
      return
    endif
    let word = expand('<cword>')
    exe '%s/' . word . '/' . subs . '/g'
  else
    sil! exe '%s//' . subs . '/g'
  endif
endfun
