command! -nargs=? EF call ef#Commander(<f-args>)
command! Go silent exe '!google-chrome-stable %'
command! Q exe 'q!'
command! Tab2 set softtabstop=2 | set tabstop=2 | set shiftwidth=2
command! Tab4 set softtabstop=4 | set tabstop=4 | set shiftwidth=4

" augroup TabOptions
"   autocmd!
"   autocmd FileType asm,python,sql,go setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
" augroup END

augroup RunFile
  autocmd!
  autocmd FileType python nmap <leader>rr :!python %<CR>
  autocmd FileType c      nmap <leader>rr :!gcc %<CR>
  autocmd FileType cpp    nmap <leader>rr :!clang++ %<CR>
augroup END

let g:input_toggle = 0
function! Fcitx2en()
  let s:input_status = system("fcitx5-remote")
  if s:input_status == 2
    let g:input_toggle = 1
    let l:a = system("fcitx5-remote -c")
  endif
endfunction

function! Fcitx2zh()
  let s:input_status = system("fcitx5-remote")
  if s:input_status != 2 && g:input_toggle == 1
    let l:a = system("fcitx5-remote -o")
    let g:input_toggle = 0
  endif
endfunction

" set timeoutlen=150
" set input method to en when leaving insert mode
autocmd InsertLeave * call Fcitx2en()
" reset original input method when entering insert mode
autocmd InsertEnter * call Fcitx2zh()
