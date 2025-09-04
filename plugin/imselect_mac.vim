let g:enable_imselect = 0

if !IsMac() || g:enable_imselect == 0
  finish
endif

let g:imselect = g:config_dir .. '/bin/select'
let g:input_toggle = 0
let s:im_en = 'com.apple.keylayout.ABC'
let s:im_zh = 'org.fcitx.inputmethod.Fcitx5.fcitx5'

if !filereadable(g:imselect)
  let imselect_src = g:imselect .. '.m'
  call system(["/usr/bin/clang", "-framework", "foundation", "-framework", "carbon", "-O3", "-o", g:imselect, imselect_src])
endif

fun! s:im_insert_leave()
  let curim = system(g:imselect)
  if curim !~# s:im_en
    let g:input_toggle = 1
    let s:im_zh = curim
    call jobstart(g:imselect . ' ' . s:im_en)
  endif
endfun

fun! s:im_insert_enter()
  if g:input_toggle == 1 && system(g:imselect) =~# s:im_en
    let g:input_toggle = 0
    call jobstart(g:imselect . ' ' . s:im_zh)
  endif
endfun

fun! s:im_default()
  if mode() == 'n'
    call jobstart(g:imselect . ' ' . s:im_en)
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
