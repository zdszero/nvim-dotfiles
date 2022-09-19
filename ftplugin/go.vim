setlocal noexpandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
iabbrev ,s :=

fun! s:run_file()
  let l:filename = expand('%')
  if l:filename =~# '_test\.go'
    exe '!go test -v'
  else
    exe '!go run %'
  endif
endfun

fun! s:test_function()
  let lineno = line('.')
  while 1
    let func_name = matchstr(getline(lineno), '\v^func \zsTest\w+\ze')
    if lineno <= 0 || !empty(func_name)
      break
    endif
    let lineno = lineno - 1
  endwhile
  if !empty(func_name)
    exe '!go test -run=' .. func_name .. ' -v'
  endif
endfun

nmap <leader>rr :call <SID>run_file()<CR>
nmap <leader>rf :call <SID>test_function()<CR>
