if !IsWSL()
  finish
endif

let g:enable_imselect = 1

let g:input_toggle = 0
let g:imselect_see = g:config_dir . '/bin/im-select-mspy.exe'
let g:imselect_toggle = g:imselect_see . ' -k=ctrl+space'
let s:im_zh = '中文模式'
let s:im_en = '英语模式'


fun! s:im_insert_leave()
  let curim = iconv(system(g:imselect_see), 'gbk', 'utf-8')
  if curim !~# s:im_en
    let g:input_toggle = 1
    let s:im_zh = curim
    call jobstart(g:imselect_toggle . ' ' . s:im_en)
  endif
endfun

fun! s:im_insert_enter()
  let curim = iconv(system(g:imselect_see), 'gbk', 'utf-8')
  if g:input_toggle == 1 && curim =~# s:im_en
    let g:input_toggle = 0
    call jobstart(g:imselect_toggle . ' ' . s:im_zh)
  endif
endfun

fun! s:im_default()
  if mode() == 'n'
    call jobstart(g:imselect_toggle . ' ' . s:im_en)
  endif
endfun

augroup SwitchInputMethod
  au!
  " set input method to en when leaving insert mode
  au InsertLeave * call s:im_insert_leave()
  " reset original input method when entering insert mode
  au InsertEnter * call s:im_insert_enter()
  " back to vim set default im
  au FocusGained * call s:im_default()
augroup END
