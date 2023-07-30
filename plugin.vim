let s:plug_dir = g:config_dir..'/plugged'

call plug#begin(s:plug_dir)

""""""""""""""""""""""
"    ENHANCE VIM     "
""""""""""""""""""""""
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'junegunn/vim-easy-align'
Plug 'gcmt/wildfire.vim'
Plug 'hotoo/pangu.vim'
""""""""""""""""""""""
"      BUTTER UI     "
""""""""""""""""""""""
Plug 'mhinz/vim-startify'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vista.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'antoinemadec/coc-fzf'
""""""""""""""""""""""
"  FILETYPE PLUGINS  "
""""""""""""""""""""""
Plug 'plasticboy/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'
Plug 'rhysd/vim-clang-format'
Plug 'lervag/vimtex'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'vim-test/vim-test'

call plug#end()
