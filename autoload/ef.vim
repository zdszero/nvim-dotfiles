function! s:EditFile(filename)
  exe 'edit ' . g:config_dir . a:filename
endfunction

function ef#Commander(...)
  " if no parameters, edit vimrc
  if a:0 == 0
    edit $MYVIMRC
    return 0
  endif

  let l:arg = a:1

  " option
  if l:arg == 'o'
    call s:EditFile('option.vim')
  elseif l:arg == 'm'
    call s:EditFile('mapping.vim')
  elseif l:arg == 'p'
    call s:EditFile('plugin.vim')
  elseif l:arg == 'c'
    call s:EditFile('command.vim')
  elseif l:arg == 's'
    call s:EditFile('UltiSnips/' . &ft . '.snippets')
  elseif l:arg == 't'
    call s:EditFile('ftplugin/' .. &ft  .. '.vim')
  else
    echoerr 'Option not defined!'
  endif

endfunction
