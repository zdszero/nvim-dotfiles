fun! s:load_project_setting()
  if index(v:argv, '+Project') >= 0
    " Read prior state
    if !isdirectory('.vim')
      call mkdir('.vim')
    endif
    set shadafile=.vim/shada.main

    let g:project_dir = getcwd()
    if filereadable('.vim/Session.vim')
      source .vim/Session.vim
    endif

    exe 'cd '..g:project_dir
    " Load project specific config
    if filereadable('.nvimrc')
      source .nvimrc
    endif

    " Save every 30 minutes and on exit
    function! SaveState(tid)
      mksession! .vim/Session.vim
      wshada
    endfunction
    autocmd VimLeave * call SaveState(0)
    call timer_start(30 * 60000, function('SaveState'), {'repeat': -1})
  endif
endfun

command! -nargs=0 LoadProject call s:load_project_setting()
