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

fun! Imselect2en()
  let s:input_status = system(g:imselect)
  if s:input_status =~# s:im_zh
    let g:input_toggle = 1
    call system(g:imselect . ' ' . s:im_en)
  endif
endfun

fun! Imselect2zh()
  let s:input_status = system(g:imselect)
  if s:input_status =~# s:im_en && g:input_toggle == 1
    let g:input_toggle = 0
    call system(g:imselect . ' ' . s:im_zh)
  endif
endfun

augroup SwitchInputMethod
  au!
  " set input method to en when leaving insert mode
  au InsertLeave * call Imselect2en()
  " reset original input method when entering insert mode
  au InsertEnter * call Imselect2zh()
augroup END
