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

fun! s:format_cjk_text() range
  let cmd_range = a:firstline..','..a:lastline
  silent! exe cmd_range..'s/ //g'
  silent! exe cmd_range..'s/\v[a-zA-Z]+/ \0 /g'
  silent! exe cmd_range..'s/\,/，/g'
  silent! exe cmd_range..'s/\./。/g'
  silent! exe cmd_range..'s/:/：/g'
  silent! exe cmd_range..'s/!/！/g'
endfun

xmap <silent> gQ :call <SID>format_to_oneline()<CR>
xmap gW :call <SID>format_cjk_text()<CR>
