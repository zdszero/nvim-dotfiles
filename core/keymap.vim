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
nnoremap j gj
nnoremap k gk
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
nnoremap <backspace> <c-o>
nnoremap \ <c-i>
" insert
inoremap <c-l> <esc>
inoremap <c-f> <Right>
inoremap <c-b> <Left>
inoremap <c-a> <c-c>I
inoremap <c-e> <c-c>A
inoremap <c-q> <c-c>gUawea

" copy and paste
if IsWSL()
	nnoremap V :call setreg('+', substitute(getreg('+'), '\r', '', 'g'))<CR>"+p
else
  nnoremap V "+p
endif
xnoremap C "+y

" alphabet
nnoremap U gUiw
nnoremap R :source $MYVIMRC<CR>
nnoremap Q :q<CR>
nnoremap <leader>q :q!<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>:let @0=""<CR>

fun s:open_netrw()
  if &filetype == 'netrw'
    exe 'bd'
  else
    Ex
  endif
endfun

nnoremap <silent> <leader>e :call <SID>open_netrw()<CR>

" resize
nnoremap <up> :res +5<CR>
nnoremap <down> :res -5<CR>
nnoremap <left> :vertical resize-5<CR>
nnoremap <right> :vertical resize+5<CR>

"
" SOME CUSTOM KEYMAPS
"
nnoremap * :<C-u>call <SID>search_cword()<CR>/<C-R>=@/<CR><CR>
nnoremap # :<C-u>call <SID>search_cword()<CR>?<C-R>=@/<CR><CR>
xnoremap * :<C-u>call <SID>visual_star_search('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>visual_star_search('?')<CR>?<C-R>=@/<CR><CR>

nnoremap [v <cmd> call <SID>last_edit_file()<cr>
nnoremap ]v <cmd> call <SID>last_edit_file()<cr>

nnoremap [b :bprev<CR>
nnoremap ]b :bnext<CR>

nmap <silent> <c-t> :FloatermToggle<CR>
tmap <silent> <c-t> <Esc>:FloatermToggle<CR>

xmap <silent> gQ :call <SID>format_to_oneline()<CR>

tnoremap <c-[> <C-\><C-N>
tnoremap <esc> <C-\><C-N>
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>

nmap <leader>ts :TestNearest<CR>
nmap <leader>tf :TestFile<CR>
nmap <leader>th :TestSuite<CR>

nmap <leader>rw :call <SID>rename_visual_selection()<CR>

fun! s:search_cword()
  let cword = expand('<cword>')
  let @/ = '\<' . cword . '\>'
  let @0 = @/[2:-3]
endfun

fun! s:visual_star_search(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
  let @0 = @/[2:-3]
endfun

fun! s:last_edit_file()
  let v:errmsg = ''
  silent! normal 
  if v:errmsg == ''
    return
  endif
  bprevious
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
  let subs = input('rename to: ')
  if subs == ''
    return
  endif
  if @0 == ""
    let word = expand('<cword>')
    exe '%s/' . word . '/' . subs . '/g'
  else
    sil! exe '%s//' . subs . '/g'
  endif
endfun

call LoadConfig('core/move.vim')
