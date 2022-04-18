let &packpath = &runtimepath

let g:config_dir = expand("<sfile>:p:h") . '/'

function g:LoadConfig(filename)
  exe 'source ' . g:config_dir . a:filename
endfunction

call g:LoadConfig('option.vim')
call g:LoadConfig('mapping.vim')
call g:LoadConfig('command.vim')
call g:LoadConfig('plugin.vim')
call g:LoadConfig('color.vim')
call g:LoadConfig('coc.vim')
call g:LoadConfig('util.vim')

if has("nvim")
  lua require('indent_line')
  lua require('buffer_line')
endif
