set t_Co=256

colorscheme one

set background=light
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

let g:one_allow_italics = 1 " I love italic for comments

" let g:indent_blankline_char = '•'
let g:indent_blankline_space_char_blankline = ' '
" let g:indent_blankline_filetype = ['python', 'go']
let g:indent_blankline_filetype_exclude = ['startify', 'coc-explorer', 'cmake']
let g:indent_blankline_buftype_exclude = ['terminal', 'help']

au FileType racket,scheme call rainbow#load()

let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1
