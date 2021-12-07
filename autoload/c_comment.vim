function! c_comment#CommentArea() range
  if match(getline(a:firstline), '\v\C/\*') != -1
    exe a:lastline . 'd'
    exe a:firstline . 'd'
    let l:start = a:firstline
    let l:end = a:lastline - 2
    exe l:start . ',' . l:end . 's/\v \* (.*)/\1'
  else
    exe a:firstline . ',' . a:lastline . 's/.*/ * \0'
    call append(a:firstline - 1, '/*')
    call append(a:lastline + 1, ' */')
  endif
endfunction
