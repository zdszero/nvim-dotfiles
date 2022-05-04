iabbrev <= \leq
iabbrev >= \geq
iabbrev != \neq

fun! s:MakeMathBlock () range
  '<,'> s/ //g
  '<,'> s/[\x00-\xff]\+/$\0$/g
endfun

fun! s:OpenPdfFile()
  let l:dir = expand('%:p:h')
  let l:filename = expand('%:p:t')
  let l:prefix = matchstr(l:filename, '\v\ze^.*\ze\.')
  let l:pdf_file = l:prefix . '.pdf'
  call jobstart('zathura ' . l:pdf_file, {'cwd': l:dir})
endfun

fun! s:HasCJK()
  let l:linenum = 1
  while l:linenum <= line('$')
    let l:line = getline(l:linenum)
    if l:line =~# '\v^$' || l:line =~# '\v^\%'
      let l:linenum = l:linenum + 1
      continue
    elseif l:line =~# '\\documentclass' || l:line =~# '\\usepackage'
      if match(l:line, 'ctex') != -1
        return 1
      endif
      let l:linenum = l:linenum + 1
      continue
    else
      break
    endif
  endwhile
  return 0
endfun

fun! s:CompileTex()
  if s:HasCJK()
    AsyncRun xelatex %
  else
    AsyncRun pdflatex %
  endif
endfun

command! OpenPdf call s:OpenPdfFile()

inoremap ;m $$<left>
inoremap ;M \[\]<left><left>
inoremap ;f <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap <c-f> <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;b \textbf{} <++><Esc>F}i
inoremap ;i \textit{} <++><Esc>F}i
inoremap ;1 \section{} <++><Esc>F}i
inoremap ;2 \subsection{} <++><Esc>F}i
inoremap ;3 \subsubsection{} <++><Esc>F}i
nmap <leader>p :call mdip#TexClipboardImage()<cr>
nmap <leader>rr :call <SID>CompileTex()<cr>
nmap <silent> <leader>d :call mdip#DeleteTexPicture()<CR>
vnoremap <silent> <c-f> :call <SID>MakeMathBlock()<CR>
