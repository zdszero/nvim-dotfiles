command! H2Cpp :call h2cpp#Execute()

let g:clang_format#code_style = "llvm"
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format_on_insert_leave = 0
let g:clang_format#detect_style_file = 1
let g:clang_format#style_options = {
            \ "IndentWidth": 4,
            \ "Standard" : "C++11"}

nnoremap <buffer><Leader>f :<C-u>ClangFormat<CR>
vnoremap <buffer><Leader>f :ClangFormat<CR>
