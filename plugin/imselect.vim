if !has('mac')
  finish
endif

let g:imselect = g:config_dir .. '/bin/select'
let g:input_toggle = 0
let s:im_en = 'com.apple.keylayout.ABC'
let s:im_zh = 'com.apple.inputmethod.SCIM.ITABC'

if !filereadable(g:imselect)
  let imselect_src = g:imselect .. '.m'
  call system(["/usr/bin/clang", "-framework", "foundation", "-framework", "carbon", "-O3", "-o", g:imselect, imselect_src])
endif

fun! s:im_insert_leave()
  if system(g:imselect) =~# s:im_zh
    let g:input_toggle = 1
    call system(g:imselect . ' ' . s:im_en)
  endif
endfun

fun! s:im_insert_enter()
  if g:input_toggle == 1 && system(g:imselect) =~# s:im_en
    let g:input_toggle = 0
    call system(g:imselect . ' ' . s:im_zh)
  endif
endfun

fun! s:im_default()
  if mode() == 'n'
    call system(g:imselect . ' ' . s:im_en)
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
