""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Telescope                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>sd :<C-u>CocFzfList diagnostics --current-buf<CR>
nmap <silent> <leader>so :<C-u>CocFzfList outline<CR>
nmap <silent> <leader>sc :<C-u>CocFzfList commands<CR>

nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ?
      \':GFiles<CR>' : ':Files<CR>'
nmap <silent> <leader>sn :exe 'Files ' . g:config_dir<cr>
nmap <silent> <leader>sb :Buffers<CR>
nmap <silent> <leader>st :Colors<CR>
nmap <silent> <leader>sl :Lines<CR>
nmap <silent> <leader>sg :Rg<CR>
nmap <silent> <leader>sC :Commands<CR>
nmap <silent> <leader>sh :Helptags<CR>

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
