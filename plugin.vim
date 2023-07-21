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
Plug 'unblevable/quick-scope'
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
Plug 'doums/darcula'
Plug 'sainnhe/gruvbox-material'
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
Plug 'rhysd/vim-clang-format'
Plug 'lervag/vimtex'

call plug#end()
