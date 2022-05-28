" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-git',
  \ 'coc-clangd',
  \ 'coc-snippets',
  \ 'coc-explorer',
  \ 'coc-highlight',
  \ 'coc-cmake',
  \ 'coc-sh',
  \ 'coc-pyright',
  \ 'coc-texlab',
  \ 'coc-sumneko-lua',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-json',
  \ 'coc-yaml'
  \]

let g:coc_filetype_map = {
  \ 'h': 'c',
  \ 'hpp': 'cpp',
  \ 'zsh': 'sh',
  \ 'vimwiki': 'markdown'
  \ }

let g:coc_explorer_global_presets = {
\   'left': {
\     'file-child-template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]',
\     'width': 25
\   },
\   'simplify': {
\     'file-child-template': '[git | 2] [selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]',
\     'position': 'floating'
\   }
\ } 

fun! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfun

fun! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfun

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>
" coc explorer mapping
nmap <silent> <leader>e :CocCommand explorer --sources file+ --preset left<cr>
" coc general mapping
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" diagnostics
nmap [e <plug>(coc-diagnostic-prev)
nmap ]e <plug>(coc-diagnostic-next)
nmap <silent> <leader>ca <plug>(coc-codeaction)
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<c-d>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<c-u>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
" coc snippet mapping

" SUPER TAB
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ "\<TAB>"
" let g:coc_snippet_next = '<tab>'
" let g:coc_snippet_prev = '<s-tab>'

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
inoremap <silent><expr> <TAB>
  \ pumvisible() ? coc#_select_confirm() :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
  \ "\<TAB>"

inoremap <silent><expr> <cr> "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
xmap <tab> <Plug>(coc-snippets-select)
xmap <leader>x <Plug>(coc-convert-snippet)
" map func and class obj
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
nmap <leader>f :call CocAction('format')<CR>

" navigate chunks of current buffer
nmap [h <Plug>(coc-git-prevchunk)
nmap ]h <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
nmap <leader>g< :CocCommand git.chunkStage<CR>
nmap <leader>g> :CocCommand git.chunkUnstage<CR>

nmap <leader>o :CocOutline<CR>

nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <leader>rf <plug>(coc-refactor)
