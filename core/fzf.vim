fun! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfun

fun! s:get_root_dir()
  if s:is_in_git_directory()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  else 
    return g:initial_dir
  endif
endfun

let $BAT_THEME='Monokai Extended Light'
let $FZF_DEFAULT_OPTS='--layout=default'
let $FZF_DEFAULT_COMMAND='fd -t f -E venv'

nmap <silent> gr <Plug>(coc-references)
nmap <silent> <leader>sd :<C-u>CocFzfList diagnostics --current-buf<CR>
nmap <silent> <leader>so :<C-u>CocFzfList outline<CR>
nmap <silent> <leader>sc :<C-u>CocFzfList commands<CR>

command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -g '!*.{png,jpg,jpeg,gif,bmp,webp,svg}' ".shellescape(<q-args>), 1, fzf#vim#with_preview({'dir': s:get_root_dir()}), <bang>0)

nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ?
  \':GFiles<CR>' : printf(':Files %s<CR>', g:initial_dir)
nmap <silent> <expr> <leader>ss printf(':Files %s<CR>', g:initial_dir)
nmap <silent> <leader>sg :PRg<CR>
nmap <silent> <leader>sn :exe 'Files ' . g:config_dir<cr>
nmap <silent> <leader>sb :Buffers<CR>
nmap <silent> <leader>st :Colors<CR>
nmap <silent> <leader>sl :Lines<CR>
nmap <silent> <leader>sC :Commands<CR>
nmap <silent> <leader>sh :Helptags<CR>
nmap <silent> <leader>ws :exe 'Files ' .. g:wiki_config['home'] .. '/' .. g:wiki_config['markdown_dir']<CR>
