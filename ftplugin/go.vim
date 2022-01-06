setlocal noexpandtab
iabbrev ,s :=

function! s:RunCurrentFile()
  let l:filename = expand('%')
  if l:filename =~# '_test\.go'
    exe '!go test -v'
  else
    exe '!go run %'
  endif
endfunction

function! s:TestCurrentFunction()
  ?Test
  let l:fun_name = matchstr(getline('.'), '\vTest\w*')
  exe '!go test -run=' . l:fun_name . ' -v'
endfunction

nmap <F4> :GoAlternate<CR>
nmap <leader>rr :call <SID>RunCurrentFile()<CR>
nmap <leader>rv :<Plug>(go-run-vertical)
nmap <leader>rf :call <SID>TestCurrentFunction()<CR>
