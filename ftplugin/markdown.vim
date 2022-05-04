set conceallevel=2
set textwidth=0

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_math = 1

fun! s:MakeMathBlock () range
  '<,'> s/[\x00-\xff]\+/$\0$/g
endfun

fun! s:VisualWordCount () range
  execute '!sed -n ' . a:firstline . ',' . a:lastline . 'p % | wc -w'
endfun

inoremap <c-;> <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;f <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;i ** <++><Esc>F*i
inoremap ;b **** <++><Esc>F*;i
inoremap ;n ****** <++><Esc>F*;;i
inoremap ;s ~~~~ <++><Esc>F~;i
inoremap ;t - [ ] 
inoremap ;h ------<Enter><Enter>
inoremap ;l [](<++>)<Esc>F]i
inoremap ;p ![](<++>)<Esc>F]i
inoremap ;c ```<Enter><++><Enter>```<Esc>kkA
inoremap ;v `` <++><Esc>F`i
inoremap ;m $$ <++><Esc>F$i
inoremap ;M $$<CR><CR>$$<CR><++><Esc>2kI
inoremap ;1 #<Space><Enter><Enter><++><Esc>2kA
inoremap ;2 ##<Space><Enter><Enter><++><Esc>2kA
inoremap ;3 ###<Space><Enter><Enter><++><Esc>2kA
inoremap ;4 ####<Space><Enter><Enter><++><Esc>2kA
inoremap ;5 #####<Space><Enter><Enter><++><Esc>2kA
inoremap ;6 ######<Space><Enter><Enter><++><Esc>2kA
nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
vnoremap <silent> <c-f> :call <SID>MakeMathBlock()<CR>
vnoremap <silent> <c-c> :call <SID>VisualWordCount()<CR>
nmap <silent> <leader>d :call mdip#DeleteMarkdownPicture()<CR>
vmap <silent> <Leader><Bslash> :EasyAlign*<Bar><CR>
map gp <Plug>Markdown_MoveToParentHeader

command! TOC call toc#GenerateToc()
