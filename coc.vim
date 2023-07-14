" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-snippets',
  \ 'coc-git',
  \ 'coc-explorer',
  \ 'coc-clangd',
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
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<cr>
" coc explorer mapping
nmap <silent> <leader>e :CocCommand explorer --sources file+ --preset left<cr>
" coc general mapping
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-type-defination)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" diagnostics
nmap [e <plug>(coc-diagnostic-prev)
nmap ]e <plug>(coc-diagnostic-next)
nmap <leader>ca <plug>(coc-codeaction)
nmap <leader>cl  <Plug>(coc-codelens-action)
nmap <leader>cf  <Plug>(coc-fix-current)
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<c-d>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<c-u>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
" coc snippet mapping

let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#_select_confirm() :
  \ coc#expandable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand',''])\<CR>" :
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
xmap <leader>f  <Plug>(coc-format-selected)

nnoremap <silent><nowait> <space>o  :call ToggleOutline()<CR>
function! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction


nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <leader>rf <plug>(coc-refactor)
nmap <leader>rw :CocCommand document.renameCurrentWord<CR>

" coc-lists

fun! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfun

fun! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfun

" nmap <silent> gr <Plug>(coc-references)
" nmap <silent> <leader>sd :CocList diagnostics --current-buf<CR>
" nmap <silent> <leader>so :CocList outline<CR>
" nmap <silent> <leader>sc :CocList commands<CR>
" nmap <silent> <leader>sC :CocList vimcommands<CR>
" nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ? ':CocList gfiles<CR>' : ':CocList files<CR>'
" nmap <silent> <leader>sn :exe 'CocList files ' .. g:config_dir<CR>
" nmap <silent> <leader>sb :CocList buffers<CR>
" nmap <silent> <leader>st :CocList colors<CR>
" nmap <silent> <leader>sl :CocList lines<CR>
" nmap <silent> <leader>sg :CocList grep<CR>
" nmap <silent> <leader>sh :CocList helptags<CR>
" nmap <silent> <leader>sm :CocList mru<CR>
" nmap <silent> <leader>ws :exe 'CocList files ' .. g:wiki_config['home'] .. '/' .. g:wiki_config['markdown_dir']<CR>
" vnoremap <leader>g :<C-u>call <SID>GrepFromSelected(visualmode())<CR>

" augroup CocGroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end
