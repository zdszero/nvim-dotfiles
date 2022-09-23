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
  \}

let g:wiki_preview_browser = 'google-chrome-stable'

nnoremap <leader>ww <Plug>WikiIndex
nnoremap <leader>wo <Plug>WikiOpenHTML
nnoremap <leader>wn <Plug>WikiCreateFollowLink
nnoremap <leader>wp <Plug>WikiGotoParent
nnoremap <leader>wd <Plug>WikiDeleteLink
nnoremap <leader>wr <Plug>WikiRenameLink
nnoremap <leader>wm <Plug>WikiMoveLink
nnoremap <leader>wh <Plug>Wiki2HTML
nnoremap <leader>wH <Plug>WikiAll2HTML
nnoremap <leader>wb <Plug>Wiki2HTMLBrowse
nnoremap <leader>wi <Plug>WikiPasteImage

"
" Git
"
nmap <leader>gs :Git status<CR>
nmap <leader>ga :Git add -A
nmap <leader>gc :Git commit -m ""<Left>
nmap <leader>gr :Git restore %
nmap <leader>gd :Git diff %<CR>
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

"
" indent blank line
"
let g:indent_blankline_filetype_exclude = ['startify', 'coc-explorer', 'cmake', 'markdown', 'tex', 'vista', 'coctree']
let g:indent_blankline_buftype_exclude = ['terminal', 'help']
let g:indent_blankline_bufname_exclude = ['__vista__']
