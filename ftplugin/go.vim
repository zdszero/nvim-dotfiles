setlocal noexpandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
iabbrev ,s :=

fun! s:RunCurrentFile()
  let l:filename = expand('%')
  if l:filename =~# '_test\.go'
    exe '!go test -v'
  else
    exe '!go run %'
  endif
endfun

fun! s:TestCurrentFunction()
  ?Test
  let l:fun_name = matchstr(getline('.'), '\vTest\w*')
  exe '!go test -run=' . l:fun_name . ' -v'
endfun

nmap <F4> :GoAlternate<CR>
nmap <leader>rr :call <SID>RunCurrentFile()<CR>
nmap <leader>rv :<Plug>(go-run-vertical)
nmap <leader>rf :call <SID>TestCurrentFunction()<CR>
