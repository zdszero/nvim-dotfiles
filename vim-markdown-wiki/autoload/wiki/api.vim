fun! s:wiki_html_dir_path()
  return g:wiki_config['home']..'/'..g:wiki_config['html_dir']
endfun

fun! s:wiki_html_path(html_rel)
  return s:wiki_html_dir_path()..'/'..a:html_rel
endfun

fun! s:wiki_markdown_dir_path()
  return g:wiki_config['home']..'/'..g:wiki_config['markdown_dir']
endfun

fun! s:wiki_markdown_path(md_rel)
  return s:wiki_markdown_dir_path()..'/'..a:md_rel
endfun

fun! wiki#api#goto_parent_link()
  let filename = expand('%')
  if filename ==# 'index.md'
    let parent_link = expand('%:p:h:h') .. '/' .. 'index.md'
  else
    let parent_link = expand('%:p:h') .. '/' .. 'index.md'
  endif
  if filereadable(parent_link)
    exe 'e ' .. parent_link
  else
    echomsg 'no parent link for this file!'
  endif
endfun

fun! wiki#api#create_follow_link()
  let line = getline('.')
  if line =~# '\v\[.*\]\(.*\)'
    let title = matchstr(line, '\[\zs.*\ze\]')
    let goto_file = matchstr(line, '(\zs.*\ze)')
    let file_exist = 1
    if !filereadable(goto_file)
      let file_exist = 0
    endif
    let file_dir = fnamemodify(goto_file, ':h')
    if !isdirectory(file_dir)
      let choice = input(printf('Create directory %s ? (y/n): ', file_dir))
      if empty(choice) || choice == 'y'
        call mkdir(file_dir, 'p')
      else
        return
      endif
    endif
    exe 'edit ' .. goto_file
    if file_exist == 0
      call s:wiki_add_meta_data(title)
    endif
  else
    let goto_file = substitute(line, ' ', '_',  'g')
    if goto_file !~# '\.md$'
      let goto_file = goto_file..'.md'
    endif
    let md_link = '[' .. line .. ']' .. '(' .. goto_file .. ')'
    call setline(line('.'), md_link)
    w
  endif
endfun

fun! s:try_rename(from, to)
  let res = rename(a:from, a:to)
  if res != 0
    echoerr 'fail to rename '..a:from..' to '..a:to
  endif
endfun

fun! wiki#api#rename_link()
  let line = getline('.')
  let mdpath = matchstr(line, '\v\[.*\]\(\zs.*\ze\)')
  if !empty(mdpath)
    " change markdown link in current line
    let hint = input("Rename to: ")
    if empty(hint)
      return
    endif
    let new_name = substitute(hint, " ", "_", "g")..'.md'
    let name = fnamemodify(mdpath, ':t')
    let parent_dir = fnamemodify(mdpath, ':h')
    let new_mdpath = parent_dir.."/"..new_name
    let new_line = substitute(line, '\[.*\](.*)', '['..hint..']'..'('..new_mdpath..')', '')
    call setline(line('.'), new_line)
    " rename markdown and html files
    call s:try_rename(mdpath, new_mdpath)
    let parent_absdir = expand('%:p:h') .. '/' .. parent_dir
    let reldir = s:relative_path_to(s:wiki_markdown_dir_path(), parent_absdir)
    let htmlpath = s:wiki_html_path(reldir .. '/' .. substitute(name, '.md', '.html', ''))
    if !filereadable(htmlpath)
      return
    endif
    let new_htmlpath = s:wiki_html_path(reldir .. '/' .. substitute(new_name, '.md', '.html', ''))
    call s:try_rename(htmlpath, new_htmlpath)
  endif
endfun

fun! s:change_all_image_links(dir, filepath)
  let cnt = count(a:dir, '/') + 1
  if a:dir =~# '^\.\.'
    let sub = repeat('\.\.\/', cnt) .. 'docs'
    let pat = 'docs'
  else
    let sub = 'docs'
    let pat = repeat('\.\.\/', cnt) .. 'docs'
  endif
  let cmd = printf("!sed -i 's/%s/%s/' %s", sub, pat, a:filepath)
  silent! exe cmd
endfun

fun! wiki#api#move_link()
  let line = getline('.')
  let mdpath = matchstr(line, '\v\[.*\]\(\zs.*\ze\)')
  let hint = matchstr(line, '\v\[\zs.*\ze\]\(.*\)')
  if !empty(mdpath)
    " change markdown link in current line
    let move_dir = input("Move to directory: ")
    if empty(move_dir)
      return
    endif
    let move_dir = substitute(move_dir, ' ', '_', 'g')
    if !isdirectory(move_dir)
      call mkdir(move_dir, 'p')
    endif
    let name = fnamemodify(mdpath, ':t')
    let parent_dir = fnamemodify(mdpath, ':h')
    let new_mdpath = simplify(parent_dir..'/'..move_dir..'/'..name)
    let new_line = substitute(line, '\[.*\](.*)', '['..hint..']'..'('..new_mdpath..')', '')
    call setline(line('.'), new_line)
    call s:change_all_image_links(move_dir, mdpath)
    silent! exe '!touch '..mdpath
    call s:try_rename(mdpath, new_mdpath)

    let parent_absdir = expand('%:p:h') .. '/' .. parent_dir
    let reldir = s:relative_path_to(s:wiki_markdown_dir_path(), parent_absdir)
    let htmlpath = s:wiki_html_path(reldir .. '/' .. substitute(name, '.md', '.html', ''))
    if !filereadable(htmlpath)
      return
    endif
    let target_dir = s:wiki_html_path(reldir .. '/' .. move_dir)
    if !isdirectory(target_dir)
      call mkdir(target_dir, 'p')
    endif
    let new_htmlpath = s:wiki_html_path(reldir .. '/' .. substitute(move_dir..'/'..name, '.md', '.html', ''))
    " call s:change_all_image_links(move_dir, htmlpath)
    call s:try_rename(htmlpath, new_htmlpath)
  endif
endfun

fun! wiki#api#delete_link()
  let line = getline('.')
  let md_rel = matchstr(line, '\v\[.*\]\(\zs.*\ze\)')
  if !empty(md_rel)
    let name = fnamemodify(md_rel, ':t')
    if name =~# '\.md$'
      let opt = confirm('Are you sure you want to delete this link?', "&Yes\n&No")
      let htmlname = substitute(name, '.md', '.html', '')
      let html_path = s:wiki_html_path(substitute(md_rel, '.md', '.html', ''))
      if opt == 1
        call delete(md_rel)
        call delete(html_path)
        normal! dd
        echomsg name..' and '..htmlname..' have been deleted'
      endif
    elseif name =~# '\v\.(png|jpg|jpeg|bmp|svg|gif|webp)$'
      let opt = confirm('Are you sure you want to delete this picture?', "&Yes\n&No")
      if opt == 1
        call delete(md_rel)
        normal! dd
      endif
      echomsg name..' has been deleted'
    endif
  endif
endfun

fun! s:wiki_add_meta_data(title)
  call setline(1, '% ' .. a:title)
  call setline(2, '% zdszero')
  call setline(3, '% ' .. strftime('%Y-%m-%d'))
endfun

fun! s:relative_path_to(parent, child)
  let from_dirs = split(expand(a:parent), '/')
  let to_dirs = split(expand(a:child), '/')
  let from_idx = 0
  let to_idx = 0
  while from_idx < len(from_dirs) && to_idx < len(to_dirs)
    if from_dirs[from_idx] != to_dirs[to_idx]
      break
    endif
    let from_idx += 1
    let to_idx += 1
  endwhile
  let relpath = repeat('../', len(from_dirs) - from_idx - 1)
  let relpath = relpath..join(to_dirs[to_idx:], '/')
  if from_idx == len(from_dirs) -1 && to_idx == len(to_dirs) - 1
    let relpath = './'..relpath
  endif
  return relpath
endfun

fun! wiki#api#paste_image()
  let image_dir = s:wiki_html_dir_path() .. '/images'
  let g:mdip_imgdir = s:relative_path_to(expand('%:p'), image_dir)
  call wiki#image#markdown_clipboard_image()
endfun

fun! wiki#api#open_index()
  let wiki_home = g:wiki_config['home']
  if !isdirectory(wiki_home)
    call mkdir(wiki_home, 'p')
    let msg = wiki_home .. ' has been created'
    echomsg msg
  endif
  let index_path = s:wiki_markdown_path('index.md')
  silent exe 'edit ' .. index_path
endfun

fun! wiki#api#open_html()
  let l:curfile = expand('%')
  let bufpath = expand('%:p:h')
  if bufpath !~# '^' .. g:wiki_config['home']
    echoerr 'the current file is not in wiki home directory!'
    return
  endif
  if &ft != 'markdown'
    echoerr &ft .. ' is not markdown'
    return
  endif
  let md_rel = substitute(expand('%:p'), s:wiki_markdown_dir_path(), '', '')
  let html_rel = substitute(md_rel, '\.md$', '.html', '')
  let html_path = join([g:wiki_config['home'], g:wiki_config['html_dir'], html_rel], '/')
  if exists('g:wiki_preview_browser')
    silent! exe '!'..g:wiki_preview_browser..' '..html_path
  else
    let browsers = ['firefox', 'google-chrome', 'chromium']
    for browser in browsers
      let v:errmsg = ''
      silent! exe '!'..browser..' '..html_path
      if v:errmsg == ''
        break
      endif
    endfor
  endif
  redraw
endfun

fun! wiki#api#wiki2html(browse)
  call wiki#converter#convert_current()
  if a:browse
    call wiki#api#open_html()
  endif
endfun

fun! wiki#api#wiki_all2html(convert_all)
  if a:convert_all
    call wiki#converter#convert_all()
  else
    call wiki#converter#convert_changed()
  endif
endfun
