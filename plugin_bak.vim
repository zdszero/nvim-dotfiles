call plug#begin('~/.config/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'frazrepo/vim-rainbow', { 'for': ['racket', 'scheme'] }
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/vim-easy-align'
Plug 'justinmk/vim-sneak'
Plug 'windwp/nvim-autopairs'
Plug 'liuchengxu/vista.vim', { 'on': 'Vista' }
Plug 'zdszero/nvim-hugo', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'SirVer/ultisnips'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'norcalli/nvim-colorizer.lua', { 'for': ['vim', 'html', 'css', 'yml'] }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'RRethy/vim-illuminate'
Plug 'hoob3rt/lualine.nvim'
Plug 'marko-cerovac/material.nvim'
Plug 'akinsho/nvim-bufferline.lua'
Plug 'ray-x/lsp_signature.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua', 'for': 'python' }
Plug 'mhartington/formatter.nvim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                color                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "verilog" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},               -- list of language that will be disabled
  },
}

-- oceanic darker
vim.g.material_style = 'darker'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = false
vim.g.material_italic_functions = false
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
vim.g.material_disable_background = false
--vim.g.material_custom_colors = { black = "#000000", bg = "#0F111A" }

-- Load the colorscheme
require('material').set()
require('bufferline').setup{}

-- autopairs
local npairs = require('nvim-autopairs')

npairs.setup({
  disable_filetype = { "TelescopePrompt", "racket", "scheme"},
})

EOF

luafile ~/.config/nvim/statusline.lua

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                NVIM-TELESCOPE                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require('telescope').setup{
  defaults = {
    layout_config = {
      center = {
        preview_cutoff = 40
      },
      height = 0.75,
      horizontal = {
        preview_cutoff = 120,
        prompt_position = "bottom"
      },
      vertical = {
        preview_cutoff = 40
      },
      width = 0.8
    }
  }
}
EOF

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
nnoremap <silent> gi <cmd>Telescope lsp_implementations<cr>
nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ?
      \'<cmd>Telescope git_files theme=get_dropdown<cr>' : '<cmd>Telescope find_files theme=get_dropdown<cr>'
nmap <silent> <leader>sb <cmd>Telescope buffers theme=get_dropdown<cr>
nmap <silent> <leader>st <cmd>Telescope colorscheme theme=get_dropdown<cr>
nmap <silent> <leader>sl <cmd>Telescope current_buffer_fuzzy_find<cr>
nmap <silent> <leader>sg <cmd>Telescope live_grep<cr>
nmap <silent> <leader>sw <cmd>Telescope grep_string<cr>
nmap <silent> <leader>sc <cmd>Telescope commands<cr>
nmap <silent> <leader>sh <cmd>Telescope help_tags<cr>
nmap <silent> <leader>se <cmd>Telescope lsp_workspace_diagnostics<cr>
nmap <silent> <leader>sr <cmd>Telescope lsp_references<cr>

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
let g:vista_close_on_jump=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                WILDFIRE                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map X <Plug>(wildfire-fuel)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                HUGO_NVIM                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:hugo_home_path = '~/Documents/博客'
let g:hugo_post_template = [
      \ '---',
      \ 'title: HUGO_TITLE',
      \ 'date: HUGO_DATE',
      \ 'tags: []',
      \ 'draft: true',
      \ '---',
      \ '' ]
let g:hugo_build_script_path = '~/Documents/博客/update_blog'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                VIM-POLYGOT                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_auto_insert_bullets = 1
let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NVIM-LSPCONFIG                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
local nvim_lsp = require('lspconfig')

nvim_lsp["ccls"].setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    },
    clang = {
      excludeArgs = { "-frounding-math"} ;
    },
    cache = {
      directory = "/tmp/ccls";
    };
  };
  on_attach = function(client)
    -- [[ other on_attach code ]]
    require 'illuminate'.on_attach(client)
    require "lsp_signature".on_attach()
  end,
}

-- using the default config
local servers = { "pyright", "rust_analyzer", "tsserver", "rust_analyzer", "html", "vimls", "texlab"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = function(client)
      -- [[ other on_attach code ]]
      require "lsp_signature".on_attach()
      require 'illuminate'.on_attach(client)
    end,
  }
end

EOF

hi def link LspReferenceText CursorLine 
hi def link LspReferenceWrite CursorLine
hi def link LspReferenceRead CursorLine

nnoremap <expr> <c-n> pumvisible() ? "\<c-n>" : ":lua require'illuminate'.next_reference{wrap=true}<cr>"
nnoremap <expr> <c-p> pumvisible() ? "\<c-p>" : ":lua require'illuminate'.next_reference{reverse=true,wrap=true}<cr>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               COMPLETION                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set shortmess+=c
set completeopt=menuone,noselect

" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_enable_auto_popup = 1
let g:completion_enable_snippet = 'UltiSnips'
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 0
let g:completion_trigger_keyword_length = 2
" length, alphabet, none
let g:completion_sorting = "length"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               LSP-SAGA                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua require'lspsaga'.init_lsp_saga()

function! s:show_documentation()
  if index(['vim', 'help'], &filetype) >= 0
    execute 'h ' . expand('<cword>')
  else
    lua require('lspsaga.hover').render_hover_doc()
  endif
endfunction

nnoremap <silent> gd <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> <leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<cr>
nnoremap <silent> K :call <SID>show_documentation()<cr>
nnoremap <silent> <leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> [e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]e <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               ULTISNIPS                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsSnippetDirectories = ['ultisnips']
imap <silent><expr> <c-t> compe#complete()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               LUA-TREE                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <leader>e <cmd>NvimTreeToggle<cr>
