command! -nargs=? EF call ef#Commander(<f-args>)
command! Go silent exe '!google-chrome-stable %'
command! Q exe 'q!'
command! Tab2 set softtabstop=2 | set tabstop=2 | set shiftwidth=2
command! Tab4 set softtabstop=4 | set tabstop=4 | set shiftwidth=4

" augroup TabOptions
"   autocmd!
"   autocmd FileType asm,python,sql,go setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
" augroup END

function! s:CompileAndRun(compiler)
  let l:filename = expand('%')
  let l:outfile = expand('%:t:r')
  silent exe '!' . a:compiler . ' ' . l:filename . ' -o ' . l:outfile
  exe '!./' . l:outfile
endfunction

augroup RunFile
  autocmd!
  autocmd FileType python nmap <leader>rr :!python3 %<CR>
  autocmd FileType cpp    nmap <leader>rr :call <SID>CompileAndRun('clang++')<CR>
  autocmd FileType c      nmap <leader>rr :call <SID>CompileAndRun('gcc')<CR>
augroup END

augroup CommentStyle
  autocmd!
  autocmd FileType cpp    setlocal commentstring=//\ %s
  autocmd FileType c      setlocal commentstring=//\ %s
augroup END

if executable('fcitx5-remote')
  let g:fcitx_remote_command = 'fcitx5-remote'
elseif executable('fcitx-remote')
  let g:fcitx_remote_command = 'fcitx-remote'
else
  let g:fcitx_remote_command = ''
endif

let g:input_toggle = 0
function! Fcitx2en()
  let s:input_status = system(g:fcitx_remote_command)
  if s:input_status == 2
    let g:input_toggle = 1
    let l:a = system(g:fcitx_remote_command . ' -c')
  endif
endfunction

function! Fcitx2zh()
  let s:input_status = system(g:fcitx_remote_command)
  if s:input_status != 2 && g:input_toggle == 1
    let l:a = system(g:fcitx_remote_command . ' -o')
    let g:input_toggle = 0
  endif
endfunction

" set timeoutlen=150


if g:fcitx_remote_command !=# ''
  " set input method to en when leaving insert mode
  autocmd InsertLeave * call Fcitx2en()
  " reset original input method when entering insert mode
  autocmd InsertEnter * call Fcitx2zh()
endif
