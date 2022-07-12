set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set conceallevel=2
set textwidth=0

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_math = 1

fun! <SID>visual_word_count () range
  execute '!sed -n ' . a:firstline . ',' . a:lastline . 'p % | wc -w'
endfun

fun! s:delete_image () abort
  let l:path = matchstr(getline('.'), '\v\(\zs.*\ze\)')
  if l:path ==# ''
    return
  endif
  let l:opt = confirm('Are you sure you want to delete this picture?', "&Yes\n&No")
  if l:opt == 1
    silent execute '!rm ' . './' . l:path
    silent execute 'normal dd'
  endif
endfun

inoremap <c-;> <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;f <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;i __ <++><Esc>F_i
inoremap ;b ____ <++><Esc>F_;i
inoremap ;n ______ <++><Esc>F_;;i
inoremap ;s ~~~~ <++><Esc>F~;i
inoremap ;t - [ ] 
inoremap ;h ------<Enter><Enter>
inoremap ;l [](<++>)<Esc>F]i
inoremap ;p ![](<++>)<Esc>F]i
inoremap ;c ```<Enter><++><Enter>```<Esc>kkA
inoremap ;v `` <++><Esc>F`i
inoremap ;m $$ <++><Esc>F$i
inoremap ;M $$$$ <++><Esc>F$;i
inoremap ;1 #<Space><Enter><Enter><++><Esc>2kA
inoremap ;2 ##<Space><Enter><Enter><++><Esc>2kA
inoremap ;3 ###<Space><Enter><Enter><++><Esc>2kA
inoremap ;4 ####<Space><Enter><Enter><++><Esc>2kA
inoremap ;5 #####<Space><Enter><Enter><++><Esc>2kA
inoremap ;6 ######<Space><Enter><Enter><++><Esc>2kA
inoremap ;{ \text{\{\}} <++><Esc>F\i
xnoremap <silent> <c-w> :call <SID>visual_word_count()<CR>

fun! s:get_image_info()
  if !executable('identify')
    echoerr 'install ImageMagick to use this function'
    return
  endif
  let image_path = matchstr(getline('.'), '\v\(\zs.*\ze\)')
  if image_path ==# ''
    return
  endif
  let output = system('du -h '..image_path)
  let pos = match(output, '\t')
  let image_size = output[:pos-1]
  let output = system('identify '..image_path)
  let size = matchstr(output, '\v \zs\d+x\d+\ze ')
  echo "picture size:"
  echo image_size..'  '..size
endfun

fun! s:resize_image()
  let image_path = matchstr(getline('.'), '\v\(\zs.*\ze\)')
  if image_path ==# ''
    return
  endif
  let factor = input('scale factor: ')
  let factor = float2nr(str2float(factor) * 100)
  let cmd = printf("convert %s -resize %d%% %s", image_path, factor, image_path)
  call system(cmd)
endfun

command! ImageInfo call <SID>get_image_info()
command! ImagePaste call wiki#image#markdown_clipboard_image()
command! ImageDelete call <SID>delete_image()
command! ImageResize call <SID>resize_image()
command! TOC call util#markdown#generate_toc()
