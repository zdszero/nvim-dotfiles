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
    call EditConfig('core/option.vim')
  elseif arg == 'm'
    call EditConfig('core/keymap.vim')
  elseif arg == 'p'
    call EditConfig('core/plugin.vim')
  elseif arg == 'c'
    call EditConfig('core/command.vim')
  elseif arg == 'u'
    call EditConfig('core/util.vim')
  elseif arg == 's'
    if exists(':SnippyEdit') > 0
      call EditConfig('snippets/' . &ft . '.snippets')
    else
      call EditConfig('UltiSnips/' . &ft . '.snippets')
    end
  elseif arg == 't'
    call EditConfig('ftplugin/' .. &ft  .. '.vim')
  else
    echoerr 'Option not defined!'
  endif
endfun

com! -nargs=? EF call <SID>edit_config_file(<f-args>)

fun! s:cd()
  let dir = expand('%:p:h')
  exe printf("cd %s", dir)
  let g:initial_dir = dir
endfun

com! CD call <SID>cd()

com! Tab2 setlocal softtabstop=2 | setlocal tabstop=2 | setlocal shiftwidth=2
com! Tab4 setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
com! Tab8 setlocal softtabstop=8 | setlocal tabstop=8 | setlocal shiftwidth=8

let g:autotab_src = g:config_dir..'/bin/autotab.c'
let g:autotab_dir = expand('~/.local/bin')
let g:autotab_bin = g:autotab_dir .. '/autotab'
if !isdirectory(g:autotab_dir)
  call mkdir(g:autotab_dir, 'p')
endif
if !filereadable(g:autotab_bin)
  call system(join(['gcc', g:autotab_src, '-o', g:autotab_bin, '-O3'], ' '))
endif

" http://www.kylheku.com/cgit/c-snippets/tree/autotab.c
aug SmartIndent
  au!
  au BufRead * if !empty(bufname("%")) && bufname('%') !~# 'fugitive' | execute 'set' system(g:autotab_bin .. " < " .. bufname("%")) | endif
"   au FileType asm,python,sql,go setlocal softtabstop=4 | setlocal tabstop=4 | setlocal shiftwidth=4
aug END

aug CommentStyle
  au!
  au FileType cpp    setlocal commentstring=//\ %s
  au FileType c      setlocal commentstring=//\ %s
  au FileType cuda   setlocal commentstring=//\ %s
  au FileType racket setlocal commentstring=;\ %s
  au FileType vue    setlocal commentstring=<!--\ %s\ -->
aug END
