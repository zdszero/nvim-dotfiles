let s:History = []
let s:HistMax = 16

" Public function for command
" > Window, target wind to show help
"   * 'default' or '' empty, done as split
"   * 'vertical' : show in vertical splited windown
"   * 'tab' : show in new tab
" > a:1,
"   * negtive number -1 -2 history help topic
"   * string, as help topic
"    
function help#Commander (Window, ...) abort
  let l:target = ''
  if empty(a:Window)
    let l:target = a:Window . ''
  endif

  " get target topic under cursor
  if a:0 == 0 || empty(a:1)
    let l:topic = expand('<cword>')
  else
    let l:topic = a:1
  endif

  if empty(a:Window) && tabpagenr('$') > 1
    
  endif

endfunction
