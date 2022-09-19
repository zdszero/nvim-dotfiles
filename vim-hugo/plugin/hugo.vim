" nvim-hugo plugin
" Author:  zdszero
" URL:     https://github.com/zdszero/nvim-hugo
" Version: 0.0.2
" License: MIT

if exists('g:hugo_loaded') 
  finish
endif

let g:hugo_loaded = 1

let g:hugo_home_path = get(g:, 'hugo_home_path', '~/Documents/Blog')
let g:hugo_post_template = get(g:, 'hugo_post_template', [
        \ '---',
        \ 'title: HUGO_TITLE',
        \ 'date: HUGO_DATE',
        \ 'draft: true',
        \ '---',
        \ '' ])
let g:hugo_post_suffix = get(g:, 'hugo_post_suffix', 'md')
let g:hugo_server_port = get(g:, 'hugo_server_port', 1313)

if exists('g:hugo_build_script_path')
  command! HugoBuild call hugo#build()
endif
command! HugoPost call hugo#post()
command! HugoSearch call hugo#search()
command! -bang HugoServer call hugo#server(<bang>0)
