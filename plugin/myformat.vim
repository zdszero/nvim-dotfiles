fun! s:format_to_oneline() range
  let merge_line = ''
  for lnum in range(a:firstline, a:lastline)
    let curline = getline(lnum)
    if curline =~# '-$'
      let curline = curline[:-2]
    endif
    if lnum > a:firstline
      let merge_line = merge_line .. ' '
    endif
    let merge_line = merge_line .. curline
  endfor
  let cmd_range = a:firstline .. ',' .. a:lastline
  exe cmd_range .. 'd'
  call append(a:firstline-1 > 0 ? a:firstline-1 : 0, merge_line)
endfun

xmap <silent> gQ :call <SID>format_to_oneline()<CR>
