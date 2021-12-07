" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunctio

let g:coc_global_extensions = [
      \ 'coc-cmake',
      \ 'coc-sh',
      \ 'coc-pyright',
      \ 'coc-texlab',
      \ 'coc-lua',
      \ 'coc-html',
      \ 'coc-css',
      \ 'coc-go',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-json',
      \ 'coc-highlight',
      \ 'coc-explorer',
      \ 'coc-snippets',
      \ 'coc-git',
      \ 'coc-pairs']

let g:coc_filetype_map = {
  \ 'h': 'c',
  \ 'hpp': 'cpp',
  \ 'zsh': 'sh'
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

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

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
nmap <silent> <leader>rn <Plug>(coc-rename)
" diagnostics
let g:ale_enabled = 0
nmap [e <plug>(coc-diagnostic-prev)
nmap ]e <plug>(coc-diagnostic-next)
nmap <silent> <leader>ca <Plug>(coc-codelens-action)
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<c-d>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<c-u>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
" coc snippet mapping
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<cr>" :
"       \ coc#jumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-jump',''])\<cr>" :
"       \ "\<TAB>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<TAB>"
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
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

command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OI   :call CocAction('runCommand', 'editor.action.organizeImport')

" navigate chunks of current buffer
" nmap [h <Plug>(coc-git-prevchunk)
" nmap ]h <Plug>(coc-git-nextchunk)
" nmap <leader>st :CocCommand git.chunkStage<cr>