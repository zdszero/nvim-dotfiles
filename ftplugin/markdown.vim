set expandtab
set softtabstop=4
set tabstop=4
set shiftwidth=4
set conceallevel=2
set textwidth=0

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_math = 1

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

fun! GetBackwardTag()
  let lnum = search('\v^#+ ', 'bnw')
  let line = getline(lnum)
  let tag = matchstr(line, '\v^#+ \zs.*\ze')
  return tag
endfun

fun! s:open_markdown(browser)
  let curfile = expand("%:p:h")
  if curfile =~# 'cs-kaoyan-grocery/content'
    let path = substitute(curfile, ".*/cs-kaoyan-grocery/content/", "", "g")
    let url = printf("http://127.0.0.1:1313/%s", path)
    let tag = GetBackwardTag()
    echomsg tag
    if tag != ''
      let url = url .. '/\#' .. tag
    endif
    let cmd = tolower(printf("!%s \"%s\"", a:browser, url))
    sil! exe cmd
  else
    if IsWSL()
      exe '!' .. g:wiki_preview_browser .. ' ' .. GetWSLPath(expand('%:p'))
    else
      exe '!' .. g:wiki_preview_browser .. ' %'
    endif
  endif
endfun

fun! s:yank_ref_link()
  let curfile = expand("%:p:h")
  if curfile =~# 'cs-kaoyan-grocery'
    let curline = getline('.')
    if curline =~# '^#'
      let tag = substitute(curline, '\v^\#+\s*', '', '')
    elseif curline =~# '^title:'
      let hint = matchstr(curline, 'title: \zs.*\ze')
      let tag = ''
    else
      let tag = matchstr(curline, 'id="\zs[^"]\+\ze"')
      if tag == ''
        return
      endif
    endif
    if tag != ''
      let hint = tag
    endif
    let tag = substitute(tag, ' ', '-', 'g')
    let tag = substitute(tag, '/', '', 'g')
    let path = substitute(curfile, ".*/cs-kaoyan-grocery/content", "", "g")
    if tag == ''
      let markdown_ref = printf("[%s](%s/)", hint, tolower(path))
    else
      let markdown_ref = printf("[%s](%s/#%s)", hint, tolower(path), tolower(tag))
    endif
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
if has('mac')
  nmap <leader>o :call <SID>open_markdown('open -a "Google Chrome"')<CR>
  nmap <leader>O :call <SID>open_markdown('open -a safari')<CR>
elseif has('wsl')
  nmap <leader>o :call <SID>open_markdown('/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe')<CR>
else
  nmap <leader>o :call <SID>open_markdown('google-chrome')<CR>
endif
nmap <leader>b :call <SID>wdbible_markdown()<CR>

command! ImageInfo call <SID>get_image_info()
command! -nargs=? ImagePaste call <SID>paste_image(<f-args>)
command! ImageDelete call <SID>delete_image()
command! ImageUnsharp call <SID>unsharp_image()
command! -nargs=? ImageResize call <SID>resize_image(<f-args>)
command! TOC call util#markdown#generate_toc()

call LoadConfig("ftplugin/text.vim")

command! -bang -nargs=* CRg call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case' .
  \   ' --glob "!**/408quiz/**"' .
  \   ' --glob "!**/exercise/**"' .
  \   ' --glob "!*.{png,jpg,jpeg,gif,bmp,webp,svg,drawio}" ' .
  \   ' --glob "!*_index.md" ' .
  \   shellescape(<q-args>),
  \   1,
  \   fzf#vim#with_preview({'dir': matchstr(expand("%:p:h"), ".*/cs-kaoyan-grocery/content/")}),
  \   <bang>0)

nmap <leader>sj :CRg<CR>

fun! s:autocorrect_markdown()
  let save_cursor = getpos('.')
  %!autocorrect
  " silent %!prettier --stdin-filepath %
  sil! %s#\($\n\s*\)\+\%$##
  sil! %s/\v\s*(\{\{\<.*\>\}\})/\1/
  call setpos('.', save_cursor)
endfun

nnoremap <leader>f :call <SID>autocorrect_markdown()<CR>

fun! s:handle_markdown_outline(line) abort
  let [file, line, text] = split(a:line, ':')
  execute 'normal! '.line.'Gzz'
endfun

nnoremap <leader>so :call fzf#run(fzf#wrap({
      \ 'source': 'rg --no-heading --color=never --line-number "^#+\s+.+" '.expand('%:p'),
    \ 'sink': function('<SID>handle_markdown_outline'),
    \ 'options': '--delimiter=: --preview="head -n {2} {1} \| tail -n 20"'
    \ }))<CR>

command! Renum let save_cursor = getpos(".") |  let counter = 1 | g/^##### \zs\d\+/s//\=counter/ | let counter += 1 |  call setpos('.', save_cursor)


function! ToSuperscript() range
  let l:sup_map = {
        \ '0': '⁰', '1': '¹', '2': '²', '3': '³', '4': '⁴',
        \ '5': '⁵', '6': '⁶', '7': '⁷', '8': '⁸', '9': '⁹',
        \ 'a': 'ᵃ', 'b': 'ᵇ', 'c': 'ᶜ', 'd': 'ᵈ', 'e': 'ᵉ',
        \ 'f': 'ᶠ', 'g': 'ᵍ', 'h': 'ʰ', 'i': 'ⁱ', 'j': 'ʲ',
        \ 'k': 'ᵏ', 'l': 'ˡ', 'm': 'ᵐ', 'n': 'ⁿ', 'o': 'ᵒ',
        \ 'p': 'ᵖ', 'r': 'ʳ', 's': 'ˢ', 't': 'ᵗ', 'u': 'ᵘ',
        \ 'v': 'ᵛ', 'w': 'ʷ', 'x': 'ˣ', 'y': 'ʸ', 'z': 'ᶻ',
        \ '+': '⁺', '-': '⁻', '=': '⁼', '(': '⁽', ')': '⁾',
        \ 'A': 'ᴬ', 'B': 'ᴮ', 'D': 'ᴰ', 'E': 'ᴱ', 'G': 'ᴳ',
        \ 'H': 'ᴴ', 'I': 'ᴵ', 'J': 'ᴶ', 'K': 'ᴷ', 'L': 'ᴸ',
        \ 'M': 'ᴹ', 'N': 'ᴺ', 'O': 'ᴼ', 'P': 'ᴾ', 'R': 'ᴿ',
        \ 'T': 'ᵀ', 'U': 'ᵁ', 'V': 'ⱽ', 'W': 'ᵂ'
        \ }

  " Get the visually selected text
  let l:orig = getreg('"')
  let l:visual = ''
  for l:char in split(l:orig, '\zs')
    let l:visual .= has_key(l:sup_map, l:char) ? l:sup_map[l:char] : l:char
  endfor

  " Replace selection with superscript
  call setreg('"', l:visual)
  normal! gvp
endfunction

xnoremap g^ :<C-u>call ToSuperscript()<CR>

function! ToSubscript() range
  let l:sub_map = {
        \ '0': '₀', '1': '₁', '2': '₂', '3': '₃', '4': '₄',
        \ '5': '₅', '6': '₆', '7': '₇', '8': '₈', '9': '₉',
        \ 'a': 'ₐ', 'e': 'ₑ', 'h': 'ₕ', 'i': 'ᵢ', 'j': 'ⱼ',
        \ 'k': 'ₖ', 'l': 'ₗ', 'm': 'ₘ', 'n': 'ₙ', 'o': 'ₒ',
        \ 'p': 'ₚ', 'r': 'ᵣ', 's': 'ₛ', 't': 'ₜ', 'u': 'ᵤ',
        \ 'v': 'ᵥ', 'x': 'ₓ', '+': '₊', '-': '₋', '=': '₌',
        \ '(': '₍', ')': '₎'
        \ }

  " Get the visually selected text
  let l:orig = getreg('"')
  let l:visual = ''
  for l:char in split(l:orig, '\zs')
    let l:visual .= has_key(l:sub_map, l:char) ? l:sub_map[l:char] : l:char
  endfor

  " Replace selection with subscript
  call setreg('"', l:visual)
  normal! gvp
endfunction

xnoremap g_ :<C-u>call ToSubscript()<CR>

function! CustomPath()
  let curfile = expand('%:p')
  if curfile =~# 'cs-kaoyan-grocery'
    return substitute(curfile, '.*/cs-kaoyan-grocery/content/', '', 'g')
  else
    return expand('%:p')
  endif
endfunction

set laststatus=2
set statusline=%{CustomPath()}
