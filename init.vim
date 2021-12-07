let &packpath = &runtimepath

let g:config_dir = expand("%:p:h") . '/'
let s:config_files = [ 'option.vim', 'mapping.vim', 'plugin.vim', 'command.vim']

function s:load_config()
  for l:filename in s:config_files
    exe 'source ' . g:config_dir . l:filename
  endfor
endfunction

call s:load_config()
