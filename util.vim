" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" wildfire
map ge <Plug>(wildfire-fuel)
" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_close_on_jump=0
let g:vista#renderer#enable_icon = 1
let g:vista_update_on_text_changed = 1

"
" HUGO
"
let g:hugo_home_path = '~/Documents/blog'
let g:hugo_post_template = [
      \ '---',
      \ 'title: HUGO_TITLE',
      \ 'date: HUGO_DATE',
      \ 'tags: []',
      \ 'draft: true',
      \ '---',
      \ '' ]
let g:hugo_build_script_path = '~/Documents/blog/update_blog'

"
" VIM TEX
"
let g:vimtex_fold_enabled = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_compiler_enabled = 0

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"
" VIM WIKI
"
let g:wiki_config = {
  \ 'home': '/home/zds/Develop/Wiki',
  \ 'markdown_dir': 'sources',
  \ 'html_dir': 'docs',
  \ 'template_path': 'templates/easy_template.html',
  \ 'script_path': 'wiki2html.sh'
  \}

let g:wiki_preview_browser = 'firefox'

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

fun! s:wiki_create_follow_link()
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

fun! s:wiki_rename()
  let line = getline('.')
  let mdpath = matchstr(line, '\v\[.*\]\(\zs.*\ze\)')
  if !empty(mdpath)
    " change markdown link in current line
    let hint = input("Rename to: ")
    let new_name = substitute(hint, " ", "_", "g")..'.md'
    let name = fnamemodify(mdpath, ':t')
    let parent_dir = fnamemodify(mdpath, ':h')
    let new_mdpath = parent_dir.."/"..new_name
    let new_line = substitute(line, '\[.*\](.*)', '['..hint..']'..'('..new_mdpath..')', '')
    call setline(line('.'), new_line)
    " rename markdown and html files
    call s:try_rename(mdpath, new_mdpath)
    let htmlpath = s:wiki_html_path(substitute(name, '.md', '.html', ''))
    let new_htmlpath = s:wiki_html_path(substitute(new_name, '.md', '.html', ''))
    call s:try_rename(htmlpath, new_htmlpath)
  endif
endfun

fun! s:wiki_delete()
  let line = getline('.')
  let md_rel = matchstr(line, '\v\[.*\]\(\zs.*\ze\)')
  if !empty(md_rel)
    let name = fnamemodify(md_rel, ':t')
    let htmlname = substitute(name, '.md', '.html', '')
    let html_path = s:wiki_html_path(substitute(md_rel, '.md', '.html', ''))
    call delete(md_rel)
    call delete(html_path)
    normal! dd
    echomsg name..' and '..htmlname..' have been deleted'
  endif
endfun

fun! s:wiki_add_meta_data(title)
  call setline(1, '% ' .. a:title)
  call setline(2, '% zdszero')
  call setline(3, '% ' .. strftime('%Y-%m-%d'))
endfun

fun! s:relative_path_to(from, to)
  let from_dirs = split(expand(a:from), '/')
  let to_dirs = split(expand(a:to), '/')
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

fun! s:wiki_paste_image()
  let image_dir = s:wiki_html_dir_path() .. '/images'
  let g:mdip_imgdir = s:relative_path_to(expand('%:p'), image_dir)
  call mdip#MarkdownClipboardImage()
endfun

fun! s:wiki_index()
  let wiki_home = g:wiki_config['home']
  if !isdirectory(wiki_home)
    call mkdir(wiki_home, 'p')
    let msg = wiki_home .. ' has been created'
    echomsg msg
  endif
  let index_path = s:wiki_markdown_path('index.md')
  silent exe 'edit ' .. index_path
endfun

fun! s:wiki_open_html()
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

fun! s:wiki2html(browse)
  let bufpath = expand('%:p:h')
  if bufpath !~# '^' .. g:wiki_config['home']
    echoerr 'the current file is not in wiki home directory and cannot be converted to html'
    return
  endif
  if &ft != 'markdown'
    echoerr &ft .. ' cannot be converted to html'
    return
  endif
  py3 from md2html import convert_current_buffer
  py3 convert_current_buffer()
  call s:wiki_open_html()
endfun

fun! s:wiki_all2html(convert_all)
  if a:convert_all
    py3 from md2html import convert_all_sources
    py3 convert_all_sources()
  else
    py3 from md2html import convert_changed_sources
    py3 convert_changed_sources()
  endif
endfun

nmap <silent> <leader>ww :call <SID>wiki_index()<CR>
nmap <silent> <leader>wp :call <SID>wiki_paste_image()<CR>
nmap <silent> <leader>whh :call <SID>wiki2html(v:false)<CR>
nmap <silent> <leader>whb :call <SID>wiki2html(v:true)<CR>
nmap <silent> <leader>wn :call <SID>wiki_create_follow_link()<CR>
nmap <silent> <leader>wr :call <SID>wiki_rename()<CR>
nmap <silent> <leader>wd :call <SID>wiki_delete()<CR>
nmap <silent> <leader>wo :call <SID>wiki_open_html()<CR>
lua << EOF
vim.keymap.set("n", "<leader>ws", function()
  require('telescope.builtin').find_files({
    search_dirs={vim.g.wiki_config['home'] .. '/' .. vim.g.wiki_config['markdown_dir']}
  })
end)
EOF

command! -bang WikiAll2HTML call <SID>wiki_all2html(<bang>v:false)

"
" Git
"
nmap <leader>gs :Git status<CR>
nmap <leader>ga :Git add -A
nmap <leader>gc :Git commit -m ""<Left>
nmap <leader>gp :Git push<CR>
