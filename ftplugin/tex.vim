iabbrev <= \leq
iabbrev >= \geq
iabbrev != \neq

function! s:MakeMathBlock () range
  '<,'> s/ //g
  '<,'> s/[\x00-\xff]\+/$\0$/g
endfunction

function! s:OpenPdfFile()
  let l:dir = expand('%:p:h')
  let l:filename = expand('%:p:t')
  let l:prefix = matchstr(l:filename, '\v\ze^.*\ze\.')
  let l:pdf_file = l:prefix . '.pdf'
  call jobstart('zathura ' . l:pdf_file, {'cwd': l:dir})
endfunction

function! s:HasCJK()
  let l:linenum = 1
  while l:linenum <= line('$')
    let l:line = getline(l:linenum)
    if l:line =~# '\v^$'
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
endfunction

function! s:CompileTex()
  if s:HasCJK()
    AsyncRun xelatex %
  else
    AsyncRun pdflatex %
  endif
endfunction

command! OpenPdf call s:OpenPdfFile()

inoremap ;m $$<left>
inoremap ;M \[\]<left><left>
nmap <leader>p :call mdip#TexClipboardImage()<cr>
nmap <leader>rr :call <SID>CompileTex()<cr>
nmap <silent> <leader>d :call mdip#DeleteTexPicture()<CR>
vnoremap <silent> <c-f> :call <SID>MakeMathBlock()<CR>
