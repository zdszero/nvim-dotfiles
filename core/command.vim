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
  au FileType vue    setlocal commentstring=<!--\ %s\ -->
aug END

" https://www.sobyte.net/post/2022-01/vim-copy-over-ssh/
" copy over ssh
function! s:raw_echo(str)
  if has('win32') && has('nvim')
    call chansend(v:stderr, a:str)
  else
    if filewritable('/dev/fd/2')
      call writefile([a:str], '/dev/fd/2', 'b')
    else
      exec("silent! !echo " . shellescape(a:str))
      redraw!
    endif
  endif
endfunction

function Copy()
  let c = join(v:event.regcontents,"\n")
  let c64 = system("base64", c)
  let msg = "\e]52;c;" . trim(c64) . "\x07"
  call s:raw_echo(msg)
endfunction

autocmd TextYankPost * call Copy()
