fun! s:Gsub(expr, pat, sub)
  return substitute(a:expr, '\v\C' . a:pat, a:sub, 'g')
endfun
  
fun! s:IsMatch(expr, pat)
  return match(a:expr, '\v\C' . a:pat) != -1
endfun

fun! s:LinkTitle(line, israw)
  let l:title = s:Gsub(a:line, '(^\s*#+\s+|\s*$)', '')
  if !a:israw
    let l:title = s:Gsub(l:title, '\.', '')
    let l:title = s:Gsub(l:title, '\s+', '-')
  endif
  return l:title
endfun

fun! s:MakeLink(line)
  let l:rank = 0
  for l:idx in range(len(a:line))
    if a:line[l:idx] ==# '#'
      let l:rank = l:rank + 1
    endif
  endfor
  let l:raw_title = s:LinkTitle(a:line, 1)
  let l:link_title = s:LinkTitle(a:line, 0)
  let l:link =  '+ ' . '[' . l:raw_title . ']' . '(#' . tolower(l:link_title) . ')'
  call append(0, l:link)
  if l:rank > 2
    execute '1s/\v^\s*/' . repeat('\t', l:rank - 2)
  endif
endfun

fun! toc#GenerateToc()
  let l:lines = []
  for l:lnum in range(line('$'), 1, -1)
    let l:line = getline(l:lnum)
    if s:IsMatch(l:line, '^\s*#+')
      call add(l:lines, l:line)
    endif
  endfor
  normal! ggO
  for l:line in l:lines
    call s:MakeLink(l:line)
  endfor
endfun
