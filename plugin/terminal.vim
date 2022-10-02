if !has("nvim")
  nnoremap ]b :bnext<CR>
  nnoremap [b :previous<CR>
  nnoremap ]t :tabnext<CR>
  nnoremap [t :tabNext<CR>
  finish
endif
tnoremap <c-[> <C-\><C-N>
tnoremap <esc> <C-\><C-N>
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
