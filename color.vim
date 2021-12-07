set t_Co=256

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

let g:vscode_style = "dark"
colorscheme vscode
set background=dark

let g:sql_type_default = 'mysql'

" let g:indent_blankline_char = '•'
let g:indent_blankline_space_char_blankline = ' '
let g:indent_blankline_filetype = ['python', 'go']
let g:indent_blankline_buftype_exclude = ['terminal', 'help']

au FileType racket,scheme call rainbow#load()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "verilog" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"markdown", "vim", "cmake"},     -- list of language that will be disabled
  },
}
require("bufferline").setup{}
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                LIGHTLINE                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug 'itchyny/lightline.vim'
" Plug 'josa42/vim-lightline-coc'
" let g:lightline = {
"   \ 'colorscheme': 'one',
"   \   'active': {
"   \     'left': [['mode', 'paste'], [  'filename', 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
"   \   }
"   \ }

" register compoments:
" call lightline#coc#register()