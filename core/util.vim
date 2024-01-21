""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                colorscheme                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:sonokai_transparent_background = 1
let g:gruvbox_material_transparent_background = 0
let g:everforest_background = 'medium'
colorscheme everforest
set background=light

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             indent blank line                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_buftype = 0
let g:indent_guides_exclude_filetypes = ['startify', 'coc-explorer', 'cmake', 'markdown', 'tex', 'vista', 'coctree', 'help']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   easy-align                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

xmap ga <Plug>(EasyAlign)
map ge <Plug>(wildfire-fuel)
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_close_on_jump=0
let g:vista#renderer#enable_icon = 1
let g:vista_update_on_text_changed = 1

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
  \ 'template_path': 'templates/default.html',
  \}

let g:wiki_preview_browser = 'google-chrome-stable'
let g:wiki_generate_toc = 1

nnoremap <leader>ww <Plug>(WikiIndex)
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
nmap <leader>gi :CocCommand git.chunkInfo<CR>
nmap <leader>gu :CocCommand git.chunkUndo<CR>
nmap <leader>g> :CocCommand git.chunkStage<CR>
nmap <leader>g< :CocCommand git.chunkUnstage<CR>
nmap <leader>gf :CocCommand git.foldUnchanged<CR>
nmap <leader>gkc :CocCommand git.keepCurrent<CR>
nmap <leader>gki :CocCommand git.keepIncoming<CR>
nmap <leader>gkb :CocCommand git.keepBoth<CR>

" navigate chunks of current buffer
nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               vim-table-mode                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:table_mode_corner='+'
" let g:table_mode_corner_corner='+'
" let g:table_mode_header_fillchar='='
