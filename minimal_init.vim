let &packpath = &runtimepath

let g:config_dir = expand("<sfile>:p:h") . '/'

fun g:LoadConfig(filename)
  exe 'source ' . g:config_dir . a:filename
endfun

call g:LoadConfig('option.vim')
call g:LoadConfig('keymap.vim')
call g:LoadConfig('command.vim')

let s:plug_dir = g:config_dir . 'plugged'

call plug#begin(s:plug_dir)

Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/vim-easy-align'

call plug#end()
