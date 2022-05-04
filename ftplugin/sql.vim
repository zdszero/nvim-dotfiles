fun! s:SourceOrHeaderFile() abort
  let filename = expand('%')
  let suffix = expand('%:e')
  let source_ext = ['cpp', 'cc', 'c']
  let header_ext = ['hpp', 'h']
  if index(source_ext, suffix) != -1
    for tmp in header_ext
      let target = substitute(filename, suffix, tmp, '')
      if file_readable(target)
        return target
      endif
    endfor
  elseif index(header_ext, suffix) != -1
    for tmp in source_ext
      let target = substitute(filename, suffix, tmp, '')
      if file_readable(target)
        return target
      endif
    endfor
  endif
endfun

fun! s:CommentArea() range
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
endfun

vmap gC :call <SID>CommentArea()<cr>
nmap gC <c-v>gC

