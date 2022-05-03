let &packpath = &runtimepath

let g:config_dir = expand("<sfile>:p:h")

function LoadConfig(filename)
  exe 'so ' . g:config_dir..'/'..a:filename
endfunction

call LoadConfig('option.vim')
call LoadConfig('keymap.vim')
call LoadConfig('command.vim')
call LoadConfig('plugin.vim')
call LoadConfig('color.vim')
call LoadConfig('coc.vim')
call LoadConfig('util.vim')

if has("nvim-0.7")
  lua require('config/treesitter')
  lua require('config/indentline')
  lua require('config/bufferline')
  lua require('config/telescope')
endif
