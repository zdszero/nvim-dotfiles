let s:plug_dir = g:config_dir..'/plugged'

call plug#begin(s:plug_dir)

""""""""""""""""""""""
"    ENHANCE VIM     "
""""""""""""""""""""""
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'gcmt/wildfire.vim'
Plug 'vim-test/vim-test'
""""""""""""""""""""""
"      BUTTER UI     "
""""""""""""""""""""""
Plug 'mhinz/vim-startify'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vista.vim'
Plug 'zefei/vim-wintabs'
Plug 'zefei/vim-wintabs-powerline'
if !has('nvim')
  Plug 'preservim/vim-indent-guides'
endif
""""""""""""""""""""""
"   CUSTOM THEME     "
""""""""""""""""""""""
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'doums/darcula'
Plug 'sainnhe/everforest'
""""""""""""""""""""""
"  COMPLETE SEARCH   "
""""""""""""""""""""""
if g:config['coc_support'] == 1
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
  Plug 'junegunn/fzf.vim' " needed for previews
  Plug 'antoinemadec/coc-fzf'
endif
""""""""""""""""""""""
"  FILETYPE PLUGINS  "
""""""""""""""""""""""
if g:config["nvim_lsp_support"] == 1
  " lspconfig and nvim-cmp
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'windwp/nvim-autopairs'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'simrat39/symbols-outline.nvim'
endif

if g:config['markdown_support'] == 1
  Plug 'plasticboy/vim-markdown'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'hotoo/pangu.vim'
endif

if g:config['tex_support'] == 1
  Plug 'lervag/vimtex'
endif

if g:config['cpp_support'] == 1
  Plug 'rhysd/vim-clang-format'
endif

if g:config['python_support'] == 1
  Plug 'Vimjas/vim-python-pep8-indent'
endif

if g:config['lua_support'] == 1
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Plug 'akinsho/bufferline.nvim'
  " Plug 'kyazdani42/nvim-web-devicons'
endif

call plug#end()
