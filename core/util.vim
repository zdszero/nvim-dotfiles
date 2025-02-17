""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                colorscheme                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:sonokai_transparent_background = 1
let g:gruvbox_material_transparent_background = 0
let g:everforest_transparent_background = 0
let g:everforest_background = 'medium'

if exists("g:gui_vimr")
  colorscheme everforest
else
  colorscheme gruvbox-material
endif

if strftime('%H') > 18
  set background=dark
else
  set background=light
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   easy-align                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

xmap ga <Plug>(EasyAlign)
map ge <Plug>(wildfire-fuel)
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  vim-hugo                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  vim-tex                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vimtex_fold_enabled = 1
let g:vimtex_indent_enabled = 1
let g:vimtex_compiler_enabled = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              vimwiki-markdown                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:wiki_config = {
  \ 'home': '~/Wiki',
  \ 'markdown_dir': 'sources',
  \ 'html_dir': 'docs',
  \ 'theme': 'bootstrap',
  \}

if has('mac')
  let g:wiki_preview_browser = 'open -a "Google Chrome"'
else
  let g:wiki_preview_browser = 'google-chrome-stable'
endif

nnoremap <leader>ww <Plug>(WikiHome)
nnoremap <leader>wo <Plug>(WikiOpenHTML)
nnoremap <leader>wn <Plug>(WikiCreateFollowLink)
nnoremap <leader>wN <Plug>(WikiCreateFollowDirectory)
nnoremap <leader>wp <Plug>(WikiGotoParent)
nnoremap <leader>wd <Plug>(WikiDeleteLink)
nnoremap <leader>wr <Plug>(WikiRenameLink)
nnoremap <leader>wh <Plug>(Wiki2HTML)
nnoremap <leader>wH <Plug>(WikiAll2HTML)
nnoremap <leader>wb <Plug>(Wiki2HTMLBrowse)
nnoremap <leader>wi <Plug>(WikiPasteImage)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    GIT                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gs :Git status<CR>
nmap <leader>ga :Git add -A
nmap <leader>gc :Git commit -m ""<Left>
nmap <leader>gr :Git restore %
nmap <leader>gd :Git diff %<CR>
nmap <leader>gl :Git log --oneline --decorate --graph --all<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 SSH COPY                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>c <Plug>OSCYankOperator
nmap <leader>cc <leader>c_
vmap <leader>c <Plug>OSCYankVisual
