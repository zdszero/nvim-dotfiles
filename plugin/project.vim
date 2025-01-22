fun! s:load_project_config()
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

let s:project_meta_path = expand('~/.vimprojects.json')

function! SaveDictToJsonFile(dict, filepath)
  let json_str = json_encode(a:dict)
  call writefile([json_str], a:filepath, 'b')
endfunction

function! LoadDictFromJsonFile(filepath)
  let file_contents = readfile(a:filepath, 'b')
  let json_str = join(file_contents, "\n")
  let dict = json_decode(json_str)
  return dict
endfunction

fun! s:add_project_dir()
  if !filereadable(s:project_meta_path)
    let config = {}
  else
    let config = LoadDictFromJsonFile(s:project_meta_path)
  endif
  let cwd = getcwd()
  let dir_name = fnamemodify(cwd, ':t')
  let config[dir_name] = cwd
  call SaveDictToJsonFile(config, s:project_meta_path)
endfun

fun! s:cd_into_project()
  if !filereadable(s:project_meta_path)
    return
  endif
  let config = LoadDictFromJsonFile(s:project_meta_path)
  let choices = ['Select a project:']
  let choice_dict = {}
  let i = 1
  for [name, dir] in items(config)
    call add(choices, printf("%d. %s: %s", i, name, dir))
    let choice_dict[i] = dir
    let i = i+1
  endfor
  let select_num = inputlist(choices)
  let dir = choice_dict[select_num]
  exe 'cd ' .. dir
  let g:initial_dir = dir
endfun

command! -nargs=0 ProjectConfig call s:load_project_config()
command! -nargs=0 ProjectAdd call s:add_project_dir()
command! -nargs=0 ProjectCD call s:cd_into_project()
