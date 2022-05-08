fun! s:comment_area() range
  if match(getline(a:firstline), '\v\C/\*') != -1
    exe a:lastline . 'd'
    exe a:firstline . 'd'
    let l:start = a:firstline
    let l:end = a:lastline - 2
    exe l:start . ',' . l:end . 's/\v \* (.*)/\1'
  else
    exe a:firstline . ',' . a:lastline . 's/.*/ * \0'
    call append(a:firstline - 1, '/*')
    call append(a:lastline + 1, ' */')
  endif
endfun

xnoremap gC :call <SID>comment_area()<cr>
nnoremap gC VgC
nmap <silent> <F4> :CocCommand clangd.switchSourceHeader<CR>

let g:clang_format#code_style = "llvm"
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#detect_style_file = 1
let g:clang_format#style_options = {
            \ "ColumnLimit": 120,
            \ "Standard" : "C++11"}

nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
vnoremap <buffer><Leader>f :ClangFormat<CR>
