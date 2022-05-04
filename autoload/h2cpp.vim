fun! h2cpp#Execute()
  call s:ParseHeader()
endfun

fun! s:Gsub(expr, pat, sub)
  return substitute(a:expr, '\v\C' . a:pat, a:sub, 'g')
endfun

fun! s:ParseHeader() abort
  let l:header_file = expand('%')
  let l:header_file = substitute(l:header_file, '\v\C\.\zs.*\ze$', 'h', '')
  let l:source_file = substitute(l:header_file, '\v\C\.\zs.*\ze$', 'cpp', '')
  let l:str_list = []
  let l:defined_func = []
  let l:fname_regex = '\zs([a-zA-Z_!=><]+)\ze\s*\(.*\)'
  if filereadable(l:source_file) == 0
    call system('touch ' . l:source_file)
    call add(l:str_list, '#include "' . l:header_file . '"')
  else
    let l:defined_func = s:ParseSource(l:source_file)
  endif
  let l:template_line = ''
  if expand('%') !=# l:header_file
    exe 'edit ' . l:header_file
  endif
  normal gg
  let @/ = 'class'
  let v:errmsg = ''
  silent exe "normal /\<cr>"
  if v:errmsg != ''
    echoerr 'class not found'
    return
  endif
  let l:class_name = matchstr(getline('.'), '\vclass\s*\zs\w+\ze')
  let l:class_start_line = line('.')
  normal $%
  let l:class_end_line = line('.')
  if getline(l:class_start_line - 1) =~# '\v\s*template'
    let l:template_line = getline(l:class_start_line - 1)
    let l:template_class_name = l:class_name . '<T>'
  else
    let l:template_class_name = l:class_name
  endif
  let l:lnum = l:class_start_line + 1
  while l:lnum <= l:class_end_line - 1
    let l:line = getline(l:lnum)
    " ignore lines not ended by semi and includes ()
    if l:line !~# '\v\(.*\).*;$'
      let l:lnum = l:lnum + 1
      continue
    endif
    " deal with special cases
    if l:line =~# '\v(^\s*(if|while|for)|\=\s*(delete|default);)'
      let l:lnum = l:lnum + 1
      continue
    endif
    " for function already defined
    let l:func_name = matchstr(l:line, '\v' . l:fname_regex)
    if index(l:defined_func, l:func_name) != -1
      let l:lnum = l:lnum + 1
      continue
    endif
    call add(l:str_list, '')
    call add(l:str_list, l:template_line)
    let l:impl = s:Gsub(l:line, l:fname_regex, l:template_class_name . '::' . '\1')
    let l:impl = s:Gsub(l:impl, ';$', ' {}')
    let l:impl = s:Gsub(l:impl, '^\s+', '')
    " when the return value is class object
    if matchstr(l:impl, '\v^\zs\w+\ze\s+') ==# l:class_name
      let l:impl = substitute(l:impl, '\v^\w+', l:template_class_name, '')
    endif
    " redefination of arguments
    let l:args = matchstr(l:impl, '\v\(.*\)')
    if l:args =~# '='
      let l:impl = s:Gsub(l:impl, '\zs\s*\=.*\ze[,)]', '')
    endif
    call add(l:str_list, l:impl)
    let l:lnum = l:lnum + 1
  endwhile
  call writefile(l:str_list, l:source_file, "aS")
  exe 'edit ' l:source_file
endfun

fun! s:ParseSource(source_file)
  let l:regex = '\v' .
        \ '(' .
        \ '[a-zA-Z_][a-zA-Z0-9_]*' .
        \ '(\<[^>]{-}\>)?' .
        \ '[*&]?' .
        \ '[ \t\n]+' .
        \ ')?' .
        \ '[*&]?[a-zA-Z_][a-zA-Z0-9_]*' .
        \ '(\<[^>]{-}\>)?' .
        \ '::' .
        \ '\zs[a-zA-Z_][a-zA-Z0-9_]*' .
        \ '[<>=!]{0,2}\ze' .
        \ '\(' .
        \ '[^)]{-}' .
        \ '\)' .
        \ '[^{]{-}' .
        \ '\{'
  let l:lst = []
  call substitute(join(readfile(a:source_file), "\n"), l:regex, '\=add(l:lst, submatch(0))', 'g')
  return l:lst
endfun
