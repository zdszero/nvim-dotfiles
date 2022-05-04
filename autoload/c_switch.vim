let s:path_dict = {}

fun! s:IsMatch(expr, pat)
  return match(a:expr, '\v' . a:pat) != -1
endfun

fun! s:TargetDirPath(dirpath, pat)
  if a:dirpath == ''
    return ''
  endif
  let l:res = globpath(a:dirpath, a:pat)
  if l:res == ''
    let l:parent_dirpath = substitute(a:dirpath, '\v\/[^/]*$', '', '')
    return s:TargetDirPath(l:parent_dirpath, a:pat)
  else
    return l:res
  endif
endfun

fun! c_switch#EditCorespondingFile()
  let l:file_name = expand('%:t')
  if has_key(s:path_dict, l:file_name)
    exe 'e ' . s:path_dict[l:file_name]
    return
  endif
  if s:IsMatch(l:file_name, '\.(cpp|c|cc)$')
    let l:target_name = substitute(l:file_name, '\v\.(cpp|c|cc)$', '.h', '')
    let l:search_pat = 'inc*'
  elseif s:IsMatch(l:file_name, '\.(h|hpp)$')
    let l:target_name = substitute(l:file_name, '\v\.(h|hpp)$', '.cpp', '')
    let l:search_pat = 's*r*c*'
  else
    return
  endif
  " first find in current directory
  let l:cmd = 'find . -name ' . l:target_name
  let l:target_path = system(l:cmd)
  if l:target_path != ''
    let s:path_dict[l:file_name] = l:target_path
    let s:path_dict[l:target_name] = expand("%:p")
    exe 'e ' . l:target_path
    return
  endif
  " then to find in parent directory
  let l:dirpath = expand("%:p:h")
  let l:target_dirpath = s:TargetDirPath(l:dirpath, l:search_pat)
  if len(l:target_dirpath) == 0
    return
  endif
  let l:cmd = 'find ' . l:target_dirpath . ' -type f ' . '-name ' . l:target_name
  let l:target_path = system(l:cmd)
  if l:target_path != ''
    let s:path_dict[l:file_name] = l:target_path
    let s:path_dict[l:target_name] = expand("%:p")
    exe 'e ' . l:target_path
  endif
endfun
