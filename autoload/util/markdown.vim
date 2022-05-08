fun! s:gsub(expr, pat, sub)
  return substitute(a:expr, '\v\C' . a:pat, a:sub, 'g')
endfun
  
fun! s:is_match(expr, pat)
  return match(a:expr, '\v\C' . a:pat) != -1
endfun

fun! s:link_title(line, israw)
  let l:title = s:gsub(a:line, '(^\s*#+\s+|\s*$)', '')
  if !a:israw
    let l:title = s:gsub(l:title, '\.', '')
    let l:title = s:gsub(l:title, '\s+', '-')
  endif
  return l:title
endfun

fun! s:make_link(line)
  let l:rank = 0
  for l:idx in range(len(a:line))
    if a:line[l:idx] ==# '#'
      let l:rank = l:rank + 1
    endif
  endfor
  let l:raw_title = s:link_title(a:line, 1)
  let l:link_title = s:link_title(a:line, 0)
  let l:link =  '+ ' . '[' . l:raw_title . ']' . '(#' . tolower(l:link_title) . ')'
  call append(0, l:link)
  if l:rank > 2
    execute '1s/\v^\s*/' . repeat('\t', l:rank - 2)
  endif
endfun

fun! util#markdown#generate_toc()
  let l:lines = []
  for l:lnum in range(line('$'), 1, -1)
    let l:line = getline(l:lnum)
    if s:is_match(l:line, '^\s*#+')
      call add(l:lines, l:line)
    endif
  endfor
  normal! ggO
  for l:line in l:lines
    call s:make_link(l:line)
  endfor
endfun
