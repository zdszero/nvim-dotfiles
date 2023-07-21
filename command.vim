fun! s:edit_config_file(...)
  if a:0 == 0
    edit $MYVIMRC
    return
  endif
  if a:0 > 1
    echoerr "Use EF with 0 or 1 argument!"
  endif
  let arg = a:1
  if arg == 'o'
    call EditConfig('option.vim')
  elseif arg == 'm'
    call EditConfig('keymap.vim')
  elseif arg == 'p'
    call EditConfig('plugin.vim')
  elseif arg == 'c'
    call EditConfig('command.vim')
  elseif arg == 'u'
    call EditConfig('util.vim')
  elseif arg == 's'
    call EditConfig('UltiSnips/' . &ft . '.snippets')
  elseif arg == 't'
    call EditConfig('ftplugin/' .. &ft  .. '.vim')
  else
    echoerr 'Option not defined!'
  endif
endfun

com! -nargs=? EF call <SID>edit_config_file(<f-args>)

com! Tab2 setlocal softtabstop=2 | setlocal tabstop=2 | setlocal shiftwidth=2
com! Tab4 setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
com! Tab8 setlocal softtabstop=8 | setlocal tabstop=8 | setlocal shiftwidth=8

let g:autotab_bin = g:config_dir..'/bin/autotab'
if !filereadable(g:autotab_bin)
  let autotab_src = g:autotab_bin..'.c'
  call system(join(['gcc', g:autotab_src, '-o', g:autotab_bin, '-O3'], ' '))
endif

aug SmartIndent
  au!
  " http://www.kylheku.com/cgit/c-snippets/tree/autotab.c
  au BufRead * execute 'set' system(g:autotab_bin .. " < " .. bufname("%"))
"   au FileType asm,python,sql,go setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
aug END

aug CommentStyle
  au!
  au FileType cpp    setlocal commentstring=//\ %s
  au FileType c      setlocal commentstring=//\ %s
aug END
