"
" FZF
"
function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>sd :<C-u>CocFzfList diagnostics --current-buf<CR>
nmap <silent> <leader>so :<C-u>CocFzfList outline<CR>
nmap <silent> <leader>sc :<C-u>CocFzfList commands<CR>

nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ?
      \':GFiles<CR>' : ':Files<CR>'
nmap <silent> <leader>sn :exe 'Files ' . g:config_dir<cr>
nmap <silent> <leader>sb :Buffers<CR>
nmap <silent> <leader>st :Colors<CR>
nmap <silent> <leader>sl :Lines<CR>
nmap <silent> <leader>sg :Rg<CR>
nmap <silent> <leader>sC :Commands<CR>
nmap <silent> <leader>sh :Helptags<CR>

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
let g:vimwiki_list = [{'path': '~/Develop/Wiki/sources',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_list = [{
  \ 'auto_export': 1,
  \ 'automatic_nested_syntaxes':1,
  \ 'path_html': '~/Develop/Wiki/docs',
  \ 'path': '~/Develop/Wiki/sources',
  \ 'template_path': '~/Develop/Wiki/html',
  \ 'template_default': 'easy_template',
  \ 'syntax': 'markdown',
  \ 'ext':'.md',
  \ 'custom_wiki2html': '~/Develop/Wiki/wiki2html.sh',
\}]
let g:vimwiki_key_mappings = { 'all_maps': 0, }
" let g:vimwiki_markdown_link_ext = 1

nmap <leader>ww <Plug>VimwikiIndex
nmap <leader>ws :exe 'Files ' . g:vimwiki_list[0].path<CR>
nmap <leader>whh <Plug>Vimwiki2HTML
nmap <leader>whb <Plug>Vimwiki2HTMLBrowse
nmap <leader>wha <Plug>VimwikiAll2HTML
nmap <leader>wn <Plug>VimwikiFollowLink
nmap <leader>wp <Plug>VimwikiGoBackLink
nmap <leader>wr <Plug>VimwikiRenameFile
nmap <leader>wd <Plug>VimwikiDeleteFile
