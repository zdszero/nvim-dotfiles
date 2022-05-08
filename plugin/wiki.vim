if exists('g:wiki_loaded')
  finish
endif
let g:wiki_loaded = 1

if !exists('g:wiki_config')
  let g:wiki_config = {
    \ 'home': '/home/zds/Develop/Wiki',
    \ 'markdown_dir': 'sources',
    \ 'html_dir': 'docs',
    \ 'template_path': 'templates/easy_template.html',
    \ 'script_path': 'wiki2html.sh'
    \}
endif


nnoremap <silent><script> <Plug>WikiIndex
      \ :<c-u>call wiki#api#open_index()<CR>
nnoremap <silent><script> <Plug>WikiOpenHTML
      \ :<c-u>call wiki#api#open_html()<CR>
nnoremap <silent><script> <Plug>WikiCreateFollowLink
      \ :<c-u>call wiki#api#create_follow_link()<CR>
nnoremap <silent><script> <Plug>WikiDeleteLink
      \ :<c-u>call wiki#api#delete_link()<CR>
nnoremap <silent><script> <Plug>WikiRenameLink
      \ :<c-u>call wiki#api#rename_link()<CR>
nnoremap <silent><script> <Plug>Wiki2HTML
      \ :<c-u>call wiki#api#wiki2html(v:false)<CR>
nnoremap <silent><script> <Plug>Wiki2HTMLBrowse
      \ :<c-u>call wiki#api#wiki2html(v:true)<CR>
nnoremap <silent><script> <Plug>WikiPasteImage
      \ :<c-u>call wiki#api#paste_image()<CR>
nnoremap <silent><script> <Plug>WikiAll2HTML
      \ :<c-u>call wiki#api#wiki_all2html(v:false)<CR>

command! WikiIndex :<c-u> call wiki#api#open_index()<CR>
command! WikiDelete :<c-u> call wiki#api#delete_link()<CR>
command! WikiRename :<c-u> call wiki#api#rename_link()<CR>
command! WikiCreateLink :<c-u> call wiki#api#create_follow_link()<CR>
command! WikiFollowLink :<c-u> call wiki#api#create_follow_link()<CR>
command! WikiPasteImage :<c-u> call wiki#api#paste_image()<CR>
command! Wiki2HTML :<c-u> call wiki#api#wiki2html()<CR>
command! -bang WikiAll2HTML call wiki#api#wiki_all2html(<bang>v:false)
