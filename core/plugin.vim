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
Plug 'tpope/vim-dispatch'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'gcmt/wildfire.vim'
Plug 'vim-test/vim-test'
Plug 'junegunn/goyo.vim'
Plug 'ojroques/vim-oscyank'
Plug 'mg979/vim-visual-multi'
""""""""""""""""""""""
"      BUTTER UI     "
""""""""""""""""""""""
Plug 'mhinz/vim-startify'
Plug 'voldikss/vim-floaterm'
""""""""""""""""""""""
"   CUSTOM THEME     "
""""""""""""""""""""""
Plug 'sainnhe/sonokai'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
""""""""""""""""""""""
"  COMPLETE SEARCH   "
""""""""""""""""""""""
if g:config['coc'] == 1 && executable('node')
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
  Plug 'junegunn/fzf.vim' " needed for previews
  Plug 'antoinemadec/coc-fzf'
endif
""""""""""""""""""""""
"  FILETYPE PLUGINS  "
""""""""""""""""""""""
if g:config["nvim_lsp"] == 1
  " lspconfig and nvim-cmp
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'dcampos/nvim-snippy'
  Plug 'dcampos/cmp-snippy'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/cmp-nvim-lua'
  Plug 'windwp/nvim-autopairs'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'smjonas/snippet-converter.nvim'
endif

if g:config['markdown'] == 1
  Plug 'plasticboy/vim-markdown'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'hotoo/pangu.vim'
endif

if g:config['tex'] == 1
  Plug 'lervag/vimtex'
endif

if g:config['cpp'] == 1
  Plug 'rhysd/vim-clang-format'
endif

if g:config['python'] == 1
  Plug 'Vimjas/vim-python-pep8-indent'
endif

if has('nvim')
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'lewis6991/gitsigns.nvim'
endif

call plug#end()
