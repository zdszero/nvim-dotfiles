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
    exe '!python3'..' %'
  elseif &ft == 'racket'
    exe '!racket'..' %'
  elseif &ft == 'sh'
    !bash %
  elseif &ft == 'vim'
    so %
  else
    echoerr "the filetype run command hasn't been set!"
  endif
endfun

nmap <leader>rr :call <SID>run_file()<CR>
