" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'antoinemadec/coc-fzf'
"
" FZF
"
" function! s:is_in_git_directory()
"   silent !git rev-parse --is-inside-work-tree
"   if v:shell_error == 0
"     return 1
"   endif
"   return 0
" endfunction

" let $BAT_THEME='Monokai Extended Light'
" let $FZF_DEFAULT_OPTS='--layout=default'

" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> <leader>sd :<C-u>CocFzfList diagnostics --current-buf<CR>
" nmap <silent> <leader>so :<C-u>CocFzfList outline<CR>
" nmap <silent> <leader>sc :<C-u>CocFzfList commands<CR>

" nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ?
"       \':GFiles<CR>' : ':Files<CR>'
" nmap <silent> <leader>sn :exe 'Files ' . g:config_dir<cr>
" nmap <silent> <leader>sb :Buffers<CR>
" nmap <silent> <leader>st :Colors<CR>
" nmap <silent> <leader>sl :Lines<CR>
" nmap <silent> <leader>sg :Rg<CR>
" nmap <silent> <leader>sC :Commands<CR>
" nmap <silent> <leader>sh :Helptags<CR>
