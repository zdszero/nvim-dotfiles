set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set conceallevel=2
set textwidth=0

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_math = 1

fun! s:visual_word_count () range
  execute '!sed -n ' . a:firstline . ',' . a:lastline . 'p % | wc -w'
endfun

inoremap <c-;> <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap <c-j> <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;a <a name=""><b><++></b></a><Esc>F"i
inoremap ;i __ <++><Esc>F_i
inoremap ;b ____ <++><Esc>F_;i
inoremap ;u <u></u><++><Esc>F<;i
inoremap ;U <b><u></u></b><++><Esc>F<;;i
inoremap ;n ______ <++><Esc>F_;;i
" inoremap ;s ~~~~ <++><Esc>F~;i
inoremap ;s <span id=""><++></span><++><Esc>F"i
inoremap ;S <b><u><span id=""><++></span></u></b><++><Esc>F"i
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

fun! s:resize_image(arg)
  let image_path = matchstr(getline('.'), '\v\(\zs.*\ze\)')
  if image_path ==# ''
    return
  endif
  let factor = a:arg
  if factor == ""
    let factor = input('scale factor (0 ~ 1): ')
  endif
  let factor = float2nr(str2float(factor) * 100)
  let cmd = printf("convert %s -resize %d%% %s", image_path, factor, image_path)
  call system(cmd)
endfun

fun! s:delete_image() abort
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

fun! s:unsharp_image()
  let l:path = matchstr(getline('.'), '\v\(\zs.*\ze\)')
  if l:path ==# ''
    return
  endif
  let cmd = printf("!convert %s -unsharp 2x1.4+0.5+0 -quality 95 %s", l:path, l:path)
  sil! exe cmd
endfun

fun! s:paste_image(arg)
  if a:arg == ""
    let g:mdip_imgdir = 'img'
  else
    let g:mdip_imgdir = a:arg
  endif
  call wiki#image#markdown_clipboard_image()
endfun

fun! s:make_math_block() range
  sil! exe printf('%d,%ds/\v([\x21-\x7E]+(\s+[\x21-\x7E]+)*)/$\1$/g', a:firstline, a:lastline)
endfun

fun! s:make_code_block() range
  sil! exe printf('%d,%ds/\v([\x21-\x7E]+(\s+[\x21-\x7E]+)*)/`\1`/g', a:firstline, a:lastline)
endfun

fun! s:format_chatgpt2list() range
  let curidx = 1
  let lineno = a:firstline
  while lineno <= a:lastline
    let curline = getline(lineno)
    if empty(curline)
      let lineno = lineno + 1
      continue
    endif
    let text = "\t- "
    if lineno < a:lastline && empty(getline(lineno + 1))
      let text = printf("%d. ", curidx)
      let curidx = curidx + 1
    endif
    call setline(lineno, text .. curline)
    let lineno = lineno + 1
  endwhile
  sil! exe printf("%d,%dg/^$/d", a:firstline, a:lastline)
endfun

fun! s:open_markdown()
  let curfile = expand("%:p:h")
  if curfile =~# 'cs-kaoyan-grocery'
    let path = substitute(curfile, ".*/cs-kaoyan-grocery/content/", "", "g")
    let url = printf("http://127.0.0.1:1313/%s", path)
    let cmd = tolower(printf("!%s \"%s\"", g:wiki_preview_browser, url))
    sil! exe cmd
  else
    exe '!' .. g:wiki_preview_browser .. ' %'
  endif
endfun

fun! s:yank_ref_link()
  let curfile = expand("%:p:h")
  if curfile =~# 'cs-kaoyan-grocery'
    let curline = getline('.')
    if curline =~# '^#'
      let tag = substitute(curline, '\v^\#+\s*', '', '')
    else
      let tag = matchstr(curline, '<a name="\zs[^"]\+\ze">.*</a>')
      if tag == ''
        return
      endif
    endif
    let tag = substitute(tag, ' ', '-', 'g')
    let path = substitute(curfile, ".*/cs-kaoyan-grocery/content", "", "g")
    let markdown_ref = tolower(printf("[%s](%s/#%s)", tag, path, tag))
    echo markdown_ref
    call setreg('l', markdown_ref)
  endif
endfun

fun! s:wdbible_markdown()
  s/\%u202A//g
  s/\%u202C/ /g
  s/\v^(.*) .*/__\1__/g
  normal! oj
  let begin_lineno = line('.')
  let cur_lineno = line('.')
  let extra_line_cnt = 0
  while 1
    let nextline = getline(cur_lineno + 1)
    if empty(nextline)
      break
    elseif nextline =~# '\v^\d+'
      normal! j
      let extra_line_cnt = extra_line_cnt + 1
      let cur_lineno = cur_lineno + 1
    else
      normal! J0
    end
  endwhile
  let subcmd = printf("%d,%ds/\\v^\\d+ (.*)/> \\1/g", begin_lineno, begin_lineno + extra_line_cnt)
  exe subcmd
  if extra_line_cnt > 0
    let subcmd = printf("%d,%ds/$/>/g", begin_lineno, begin_lineno + extra_line_cnt - 1)
    sil! exe subcmd
  else
    let subcmd = printf("%ds/\\v\\s*\\d+\\s*/>> /g", begin_lineno)
    echomsg subcmd
    sil! exe subcmd
  endif
  Tcn
endfun

vmap <leader>m :call <SID>make_math_block()<CR>
vmap <leader>c :call <SID>make_code_block()<CR>
vmap <leader>l :call <SID>format_chatgpt2list()<CR>
nmap <leader>l :call <SID>yank_ref_link()<CR>
nmap <leader>o :call <SID>open_markdown()<CR>
nmap <leader>b :call <SID>wdbible_markdown()<CR>

command! ImageInfo call <SID>get_image_info()
command! -nargs=? ImagePaste call <SID>paste_image(<f-args>)
command! ImageDelete call <SID>delete_image()
command! ImageUnsharp call <SID>unsharp_image()
command! -nargs=? ImageResize call <SID>resize_image(<f-args>)
command! TOC call util#markdown#generate_toc()

call LoadConfig("ftplugin/text.vim")
