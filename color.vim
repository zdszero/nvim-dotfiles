set t_Co=256

" let g:sonokai_transparent_background = 1
colorscheme gruvbox-material
set background=light

let g:one_allow_italics = 1 " I love italic for comments

" let g:indent_blankline_char = '•'
let g:indent_blankline_space_char_blankline = ' '
" let g:indent_blankline_filetype = ['python', 'go']
let g:indent_blankline_filetype_exclude = ['startify', 'coc-explorer', 'cmake', 'c', 'cpp']
let g:indent_blankline_buftype_exclude = ['terminal', 'help']

let g:cpp_attributes_highlight = 1
let g:cpp_member_highlight = 1

lua require('bufferline').setup{}
