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

if !has("nvim")
  nnoremap ]b :bnext<CR>
  nnoremap [b :bnext<CR>
  nnoremap ]t :tabnext<CR>
  nnoremap [t :tabNext<CR>
endif
nnoremap [T :tabprevious<CR>
nnoremap ]T :tabnext<CR>

let s:terminal_bufnr = -1

fun! s:open_terminal(...)
  vsp
  normal! l
  if a:0 == 1
    exe 'terminal' . ' ' . a:1
  else
    exe 'terminal'
  endif
  exe 'vertical resize-10'
  let s:terminal_bufnr = bufnr()
endfun

fun! s:copy_and_send()
  let temp = @"
  normal! yy
  let @" = @" .. "\n"
  normal! l
  normal! p
  normal! h
  let @" = temp
endfun

fun! s:visual_copy_and_send() range
  let line_start = a:firstline
  let line_end = a:lastline
  let lines = getline(line_start, line_end)
  if len(lines) == 0
    return ''
  endif
  let content = join(lines, "\n") .. "\n"
  let temp = @"
  let @" = content
  normal! l
  normal! p
  normal! h
  let @" = temp
endfun

nmap <leader>tt :call <SID>open_terminal()<CR>
nmap <leader>tp :call <SID>open_terminal(g:python_host_prog)<CR>
nmap <leader>ti :call <SID>open_terminal('ipython3')<CR>
vmap <c-c> :call <SID>visual_copy_and_send()<CR>
nmap <c-c> :call <SID>copy_and_send()<CR>

fun! s:complie_run(compiler)
  let l:filename = expand('%')
  let l:outfile = expand('%:t:r')
  silent exe '!' . a:compiler . ' ' . l:filename . ' -o ' . l:outfile
  exe '!./' . l:outfile
endfun

fun! s:run_file()
  if &ft == 'c'
    call s:complie_run('gcc')
  elseif &ft == 'cpp'
    call s:complie_run('clang++')
  elseif &ft == 'python'
    exe '!'..g:python_host_prog .. ' %'
  elseif &ft == 'sh'
    !bash %
  elseif &ft == 'vim'
    so %
  else
    echoerr "the filetype run command hasn't been set!"
  endif
endfun

nmap <leader>rr :call <SID>run_file()<CR>

let g:playground_home = '/home/zds/Documents/nvim_playground'

fun! s:start_play(is_new)
  let ext = input('Play FileType: ')
  if ext == ''
    return
  endif
  if !isdirectory(g:playground_home)
    call mkdir(g:playground_home, 'p')
  endif
  let playfiles = split(glob(g:playground_home..'/*.'..ext), "\n")
  if empty(playfiles)
    exe 'edit '..g:playground_home..'/'..'play1.'..ext
  else
    if a:is_new
      let next_idx = matchstr(playfiles[-1], '\v\zs\d+\ze\.'..ext) + 1
      exe 'edit '..g:playground_home..'/'..'play'..next_idx..'.'..ext
    else
      exe 'edit '..playfiles[-1]
    endif
  endif
endfun

nmap <leader>pp :call <SID>start_play(v:false)<CR>
nmap <leader>pn :call <SID>start_play(v:true)<CR>

fun! s:format_to_oneline() range
  let merge_line = ''
  for lnum in range(a:firstline, a:lastline)
    let curline = getline(lnum)
    if curline =~# '-$'
      let curline = curline[:-2]
    endif
    if lnum > a:firstline
      let merge_line = merge_line .. ' '
    endif
    let merge_line = merge_line .. curline
  endfor
  let exerange = a:firstline .. ',' .. a:lastline
  exe exerange .. 'd'
  call append(a:firstline-1 > 0 ? a:firstline-1 : 0, merge_line)
endfun

xmap <silent> gQ :call <SID>format_to_oneline()<CR>
