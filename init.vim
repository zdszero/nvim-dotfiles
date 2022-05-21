let &packpath = &runtimepath

let g:config_dir = expand("<sfile>:p:h")

fun LoadConfig(filename)
  exe 'so ' . g:config_dir..'/'..a:filename
endfun

call LoadConfig('option.vim')
call LoadConfig('keymap.vim')
call LoadConfig('command.vim')
call LoadConfig('plugin.vim')
call LoadConfig('color.vim')
call LoadConfig('coc.vim')
call LoadConfig('util.vim')
