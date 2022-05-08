iabbrev <= \leq
iabbrev >= \geq
iabbrev != \neq

fun! s:open_pdf()
  let l:dir = expand('%:p:h')
  let l:filename = expand('%:p:t')
  let l:prefix = matchstr(l:filename, '\v\ze^.*\ze\.')
  let l:pdf_file = l:prefix . '.pdf'
  call jobstart('zathura ' . l:pdf_file, {'cwd': l:dir})
endfun

fun! s:has_cjk()
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

fun! s:compile_tex()
  if s:has_cjk()
    AsyncRun xelatex %
  else
    AsyncRun pdflatex %
  endif
endfun

fun! s:delete_image () abort
  let l:path = matchstr(getline('.'), '\v\{\zs.*\ze\}')
  if l:path ==# ''
    return
  endif
  let l:opt = confirm('Are you sure you want to delete this picture?', "&Yes\n&No")
  if l:opt == 1
    silent execute '!rm ' . './' . l:path
    silent execute 'normal dd'
  endif
endfun

inoremap ;m $$<left>
inoremap ;M \[\]<left><left>
inoremap ;f <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap <c-f> <Esc>/<++><CR>:nohlsearch<CR>d4li
inoremap ;b \textbf{} <++><Esc>F}i
inoremap ;i \textit{} <++><Esc>F}i
inoremap ;1 \section{} <++><Esc>F}i
inoremap ;2 \subsection{} <++><Esc>F}i
inoremap ;3 \subsubsection{} <++><Esc>F}i
nmap <leader>rr :call s:compile_tex()<cr>

command! OpenPdf call s:open_pdf()
command! PasteImage call wiki#image#tex_clipboard_image()
command! DelteteImage call s:delete_image()
