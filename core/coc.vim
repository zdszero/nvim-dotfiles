" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files
set nobackup
set nowritebackup

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Choose a usable node from possible path
" minimum version is v14.14.0
let possible_paths = ["/usr/local/bin/node", "/usr/bin/node"]
" add possible nvm path
let possible_paths = extend(possible_paths, split(glob("~/.nvm/versions/node/*/bin/node"), "\n"))
for nodepath in possible_paths
  if !filereadable(nodepath)
    continue
  endif
  let output = system(printf("%s -v", nodepath))
  let ms = matchlist(output, 'v\(\d\+\).\(\d\+\).\(\d\+\)')
  if empty(ms)
    continue
  elseif str2nr(ms[1]) < 14 || (str2nr(ms[1]) == 14 && str2nr(ms[2]) < 14)
    continue
  else
    let g:coc_node_path = nodepath
    break
  endif
endfor

let g:coc_config_home = '~/.config/nvim'

let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-snippets',
  \ 'coc-git',
  \ 'coc-explorer',
  \ 'coc-sh',
  \ 'coc-vimlsp',
  \ 'coc-json',
  \ 'coc-yaml'
  \]

if g:config['python'] == 1
  let g:coc_global_extensions = extend(g:coc_global_extensions, ['coc-pyright'])
endif

if g:config['cpp'] == 1
  let g:coc_global_extensions = extend(g:coc_global_extensions, ['coc-cmake', 'coc-clangd'])
endif

if g:config['tex'] == 1
  let g:coc_global_extensions = extend(g:coc_global_extensions, ['coc-texlab'])
endif

if g:config['webdev'] == 1
  let g:coc_global_extensions = extend(g:coc_global_extensions, ['coc-html', 'coc-css', 'coc-tsserver'])
endif

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

" Use gh to show documentation in preview window.
nnoremap <silent> gh :call <SID>show_documentation()<cr>
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
nmap <leader>cl <Plug>(coc-codelens-action)
nmap <leader>cf <Plug>(coc-fix-current)
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

fun! ToggleOutline() abort
  let winid = coc#window#find('cocViewId', 'OUTLINE')
  if winid == -1
    call CocActionAsync('showOutline', 1)
  else
    call coc#window#close(winid)
  endif
endfunction

nmap <silent> <leader>rn <Plug>(coc-rename)
nmap <leader>rf <plug>(coc-refactor)
" nmap <leader>rw :CocCommand document.renameCurrentWord<CR>
nmap <silent> <C-x> <Plug>(coc-cursors-position)
nmap <silent> <C-c> <Plug>(coc-cursors-word)
xmap <silent> <C-c> <Plug>(coc-cursors-range)
" use normal command like `<leader>xi(`
" can be used with vim-repeat
nmap <leader>x  <Plug>(coc-cursors-operator)
nmap <expr> <silent> <C-s> <SID>select_current_word()
nmap <silent> <leader>sw :call <SID>coc_search()<CR>

fun! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfun

fun! s:coc_search()
  if @0 == ""
    let pat = input('Search: ')
    if pat == ''
      return
    endif
    exe 'CocSearch ' . pat
  else
    exe 'CocSearch ' . getreg("0")
  endif
endfun

nmap <leader>gi :CocCommand git.chunkInfo<CR>
nmap <leader>gu :CocCommand git.chunkUndo<CR>
nmap <leader>g> :CocCommand git.chunkStage<CR>
nmap <leader>g< :CocCommand git.chunkUnstage<CR>
nmap <leader>gf :CocCommand git.foldUnchanged<CR>
nmap <leader>gkc :CocCommand git.keepCurrent<CR>
nmap <leader>gki :CocCommand git.keepIncoming<CR>
nmap <leader>gkb :CocCommand git.keepBoth<CR>

" navigate chunks of current buffer
nmap [x <Plug>(coc-git-prevchunk)
nmap ]x <Plug>(coc-git-nextchunk)
nmap [c <Plug>(coc-git-prevconflict)
nmap ]c <Plug>(coc-git-nextconflict)
