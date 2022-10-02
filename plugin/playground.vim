let g:playground_home = '/home/zds/Documents/nvim_playground'

fun! s:start_play(is_new)
  let ext = input('Play FileType: ')
  if ext == ''
    return
  endif
  if !isdirectory(g:playground_home)
    call mkdir(g:playground_home, 'p')
  endif
  let playfiles = split(glob(g:playground_home..'/*.'..ext), "\n")
  if empty(playfiles)
    exe 'edit '..g:playground_home..'/'..'play1.'..ext
  else
    if a:is_new
      let next_idx = matchstr(playfiles[-1], '\v\zs\d+\ze\.'..ext) + 1
      exe 'edit '..g:playground_home..'/'..'play'..next_idx..'.'..ext
    else
      exe 'edit '..playfiles[-1]
    endif
  endif
endfun

command! Playground :call <SID>start_play(v:false)
command! PlaygroundNew :call <SID>start_play(v:true)<CR>
