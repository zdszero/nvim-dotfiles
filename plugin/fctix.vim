if !has('linux')
  finish
endif

if executable('fcitx5-remote')
  let g:fcitx_remote_command = 'fcitx5-remote'
elseif executable('fcitx-remote')
  let g:fcitx_remote_command = 'fcitx-remote'
else
  let g:fcitx_remote_command = ''
  finish
endif

let g:input_toggle = 0
fun! Fcitx2en()
  let s:input_status = system(g:fcitx_remote_command)
  if s:input_status == 2
    let g:input_toggle = 1
    let l:a = system(g:fcitx_remote_command . ' -c')
  endif
endfun

fun! Fcitx2zh()
  let s:input_status = system(g:fcitx_remote_command)
  if s:input_status != 2 && g:input_toggle == 1
    let l:a = system(g:fcitx_remote_command . ' -o')
    let g:input_toggle = 0
  endif
endfun

" set timeoutlen=150

augroup SwitchInputMethod
  au!
  " set input method to en when leaving insert mode
  au InsertLeave * call Fcitx2en()
  " reset original input method when entering insert mode
  au InsertEnter * call Fcitx2zh()
augroup END
