Plug 'dense-analysis/ale'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   ALE                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" when to lint
let g:ale_disable_lsp = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_linters = {
\   'python': ['pylint'],
\   'cpp': ['g++'],
\   'c': ['gcc'],
\   'sh': ['shell'],
\   'javascript': ['standard'],
\   'css': ['stylelint'],
\   'json': ['jsonlint'],
\}
let g:ale_css_stylelint_options = '--config ~/.stylelintrc'
nmap <silent> [e <Plug>(ale_previous_wrap)
nmap <silent> ]e <Plug>(ale_next_wrap)
nmap <silent> <leader>d :ALEDetail<cr>
" error sign
let g:ale_sign_error = '✕'
let g:ale_sign_warning = '⚡'
let g:ale_sign_column_always = 0
let g:ale_fix_on_save = 0
let g:ale_virtualtext_cursor = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             LIGHTLINE                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LightlineGit () abort
  return get(g:, 'coc_git_status')
endfunction

let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [
\     [ 'mode', 'paste' ],
\     [ 'filename', 'readonly', 'modified', 'gitbranch' ,'cocstatus', 'git' ] ],
\   'right': [ [ 'lineinfo' ],
\              [ 'percent' ],
\              [ 'fileformat', 'fileencoding', 'filetype' ],
\              [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ] ],
\ },
\ 'component_function': {
\   'cocstatus': 'coc#status',
\   'git': 'LightlineGit',
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok',
\ },
\ 'separator': { 'left': '', 'right': '' },
\ 'subseparator': { 'left': '', 'right': '' }
\ }

let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
