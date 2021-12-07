let &packpath = &runtimepath

if has('win32')
  let g:config_dir = 'C:\\Users\\zds\\AppData\\Local\\nvim'
  let g:os_separator = '\\'
else
  let g:config_dir = '/home/zds/.config/nvim'
  let g:os_separator = '/'
endif

let s:config_files = [ 'option.vim', 'mapping.vim', 'plugin.vim', 'command.vim']

function s:load_config()
  for l:filename in s:config_files
    exe 'source ' . g:config_dir . g:os_separator . l:filename
  endfor
endfunction

call s:load_config()
