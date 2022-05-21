fun! s:get_path(key)
  return s:format_path(g:wiki_config['home'] .. '/' .. g:wiki_config[a:key])
endfun

fun! s:format_path(origin)
  let tmp = substitute(expand(a:origin), '//', '/', 'g')
  return substitute(tmp, '/$', '', '')
endfun

fun! s:join_path(...)
  return join(a:000, '/')
endfun

let s:markdown_dir_path = s:get_path('markdown_dir')
let s:html_dir_path = s:get_path('html_dir')
let s:template_path = s:get_path('template_path')
let s:script_path = s:join_path(g:markdown_wiki_plug_dir, 'bin', 'wiki2html.sh')

fun! s:md2html(stem)
  let depth = count(a:stem, '/')
  let html = s:join_path(s:html_dir_path, a:stem..'.html')
  let md = s:join_path(s:markdown_dir_path, a:stem..'.md')
  call system([s:script_path, md, html, s:template_path, depth])
  if !v:shell_error
    echomsg md..' has been converted to html'
  endif
endfun

fun! s:changed_sources()
  let html_files =  split(globpath(s:html_dir_path, '**/*.html'), '\n')
  let stem_dict = {}
  let changed_stems = []
  for html in html_files
    let suffix = substitute(html, s:html_dir_path .. '/', '', '')
    let stem = substitute(suffix, '.html', '', '')
    let stem_dict[stem] = getftime(html)
  endfor
  let md_files =  split(globpath(s:markdown_dir_path, '**/*.md'), '\n')
  for md in md_files
    let suffix = substitute(md, s:markdown_dir_path .. '/', '', '')
    let stem = substitute(suffix, '.md', '', '')
    if !has_key(stem_dict, stem)
      let changed_stems = add(changed_stems, stem)
    elseif getftime(md) > stem_dict[stem]
      let changed_stems = add(changed_stems, stem)
    endif
  endfor
  return changed_stems
endfun

fun! wiki#converter#convert_changed()
  for stem in s:changed_sources()
    call s:md2html(stem)
  endfor
endfun

fun! wiki#converter#convert_all()
  let md_files =  split(globpath(s:markdown_dir_path, '**/*.md'), '\n')
  for md in md_files
    let suffix = substitute(md, s:markdown_dir_path .. '/', '', '')
    let stem = substitute(suffix, '.md', '', '')
    call s:md2html(stem)
  endfor
endfun

fun! wiki#converter#convert_current()
  let md = expand('%:p')
  if md !~# '^'..s:markdown_dir_path
    echoerr 'the current file is not in wiki home directory and cannot be converted to html'
    return
  endif
  if &ft != 'markdown'
    echoerr &ft .. ' cannot be converted to html'
    return
  endif
  let suffix = substitute(md, s:markdown_dir_path .. '/', '', '')
  let stem = substitute(suffix, '.md', '', '')
  call s:md2html(stem)
endfun
