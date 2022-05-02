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
  \ 'template_path': 'html/easy_template.html',
  \ 'script_path': 'test.sh'
  \}

function! s:wiki_create_follow_link()
  let line = getline('.')
  if line =~# '\v\[.*\]\(.*\)'
    let title = matchstr(line, '\[\zs.*\ze\]')
    let goto_file = matchstr(line, '(\zs.*\ze)')
    let file_exist = 1
    if !filereadable(goto_file)
      let file_exist = 0
    endif
    exe 'edit ' .. goto_file
    if file_exist == 0
      call <SID>wiki_add_meta_data(title)
    endif
  else
    let goto_file = substitute(line, ' ', '_',  'g') .. '.md'
    let md_link = '[' .. line .. ']' .. '(' .. goto_file .. ')'
    call setline(line('.'), md_link)
  endif
endfunction

function! s:wiki_add_meta_data(title)
  call setline(1, '% ' .. a:title)
  call setline(2, '% zdszero')
  call setline(3, '% ' .. strftime('%Y-%m-%d'))
endfunction

function! s:wiki_paste_image()
  let g:mdip_imgdir = "../images"
  call mdip#MarkdownClipboardImage()
endfunction

function! s:wiki_index()
  let wiki_home = g:wiki_config['home']
  echomsg wiki_home
  if !isdirectory(wiki_home)
    call mkdir(wiki_home, 'p')
    let msg = wiki_home .. ' has been created'
    echomsg msg
  endif
  let index_path = wiki_home .. '/' .. g:wiki_config['markdown_dir'] .. '/' .. 'index.md'
  silent exe 'edit ' .. index_path
endfunction

function! s:wiki2html(browse)
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
  if a:browse == 1
    let html_path = g:wiki_config['home'] .. '/' .. g:wiki_config['html_dir']
          \.. '/' .. substitute(expand('%:p:t'), '.md', '.html', 'g')
    silent exe '!google-chrome ' .. html_path
    redraw
  endif
endfunction

function! s:wiki_all2html(convert_all)
  if a:convert_all
    py3 from md2html import convert_all_sources
    py3 convert_all_sources()
  else
    py3 from md2html import convert_changed_sources
    py3 convert_changed_sources()
  endif
endfunction

nmap <leader>ww :call <SID>wiki_index()<CR>
nmap <silent> <leader>ws :lua require('telescope.builtin').find_files({search_dirs={vim.g.wiki_config['home']}})<CR>
nmap <leader>wp :call <SID>wiki_paste_image()<CR>
nmap <leader>whh :call <SID>wiki2html(v:false)<CR>
nmap <leader>whb :call <SID>wiki2html(v:true)<CR>
nmap <leader>wn :call <SID>wiki_create_follow_link()<CR>

command! -bang WikiAll2HTML call <SID>wiki_all2html(!v:false)

"
" Git
"
nmap <leader>gs :Git status<CR>
nmap <leader>ga :Git add -A
nmap <leader>gc :Git commit -m ""<Left>
nmap <leader>gp :Git push<CR>
