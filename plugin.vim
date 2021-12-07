call plug#begin(g:config_dir . g:os_separator . 'plugged')

Plug 'mhinz/vim-startify'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'kshenoy/vim-signature'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown'
Plug 'wlangstroth/vim-racket'
Plug 'frazrepo/vim-rainbow'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
Plug 'zdszero/nvim-hugo'
Plug 'akinsho/bufferline.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'mhartington/formatter.nvim'
Plug 'skywind3000/asyncrun.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf', {'branch': 'release'}
Plug 'Mofiqul/vscode.nvim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                COLOR                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256

" Plug 'Raimondi/delimitMate'
" let g:delimitMate_expand_space = 1
" let g:delimitMate_expand_cr = 1
" let g:delimitMate_excluded_ft = "cmake"

lua <<EOF
require'nvim-treesitter.configs'.setup {
ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
ignore_install = { "verilog" }, -- List of parsers to ignore installing
highlight = {
  enable = true,              -- false will disable the whole extension
  disable = {"markdown", "vim", "cmake"},     -- list of language that will be disabled
},
}

require("bufferline").setup{}

require('formatter').setup({
filetype = {
  javascript = {
    -- prettier
    function()
      return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
        stdin = true
      }
    end
  },
  python = {
    -- autopep8
    function()
      return {
        exe = 'autopep8',
        args = {vim.api.nvim_buf_get_name(0)},
        stdin = true
      }
    end
  },
  cpp = {
      -- clang-format
     function()
        return {
          exe = "clang-format",
          args = {"--style=\"{BasedOnStyle: LLVM, IndentWidth: 2}\"", "--assume-filename", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
        }
      end
  },
  c = {
      -- clang-format
     function()
        return {
          exe = "clang-format",
          args = {"--style=\"{BasedOnStyle: LLVM, IndentWidth: 2}\"", "--assume-filename", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
        }
      end
  },
}
})
EOF

function! s:FormatCode()
  let v:errmsg = ''
  silent! Format
  if v:errmsg == ''
    return
  endif
  call CocAction('format')
endfunction

nmap <leader>f :call <SID>FormatCode()<CR>

let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

let g:vscode_style = "dark"
colorscheme vscode
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                LIGHTLINE                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Plug 'itchyny/lightline.vim'
" Plug 'josa42/vim-lightline-coc'
" let g:lightline = {
"   \ 'colorscheme': 'one',
"   \   'active': {
"   \     'left': [['mode', 'paste'], [  'filename', 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ]]
"   \   }
"   \ }

" register compoments:
" call lightline#coc#register()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 COC                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
  \ 'jst': 'html',
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                FZF-VIM                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

nmap <silent><expr> <leader>sf <SID>is_in_git_directory() ? ':GFiles<cr>' : ':Files<cr>'
nmap <leader>sb :Buffers<cr>
nmap <leader>sl :Lines<cr>
nmap <leader>sg :Rg<cr>
nmap <leader>sh :Helptags<cr>
nmap <leader>sc :CocFzfList commands<cr>
nmap <leader>sd :CocFzfList diagnostics<cr>
nmap <leader>so :CocFzfList outline<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             VIM-EASY-ALIGN                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                VISTA                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_close_on_jump=0
let g:vista#renderer#enable_icon = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                WILDFIRE                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map ge <Plug>(wildfire-fuel)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                HUGO_NVIM                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:hugo_home_path = '~/Documents/blog'
let g:hugo_post_template = [
      \ '---',
      \ 'title: HUGO_TITLE',
      \ 'date: HUGO_DATE',
      \ 'tags: []',
      \ 'draft: true',
      \ '---',
      \ '' ]
let g:hugo_build_script_path = '~/Documents/blog/update_blog'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                OTHERS                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:sql_type_default = 'mysql'

" let g:indent_blankline_char = '•'
let g:indent_blankline_space_char_blankline = ' '
let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_filetype = ['python', 'go']
let g:indent_blankline_buftype_exclude = ['terminal', 'help']

au FileType racket,scheme call rainbow#load()
