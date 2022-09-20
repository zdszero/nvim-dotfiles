let s:plug_dir = g:config_dir..'/plugged'

call plug#begin(s:plug_dir)

""""""""""""""""""""""
"    ENHANCE VIM     "
""""""""""""""""""""""
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'kshenoy/vim-signature'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-easy-align'
Plug 'gcmt/wildfire.vim'
Plug 'unblevable/quick-scope'
Plug 'chrisbra/unicode.vim'
""""""""""""""""""""""
"      BUTTER UI     "
""""""""""""""""""""""
Plug 'mhinz/vim-startify'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vista.vim'
Plug 'itchyny/lightline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'
""""""""""""""""""""""
"   CUSTOM THEME     "
""""""""""""""""""""""
Plug 'rakr/vim-one'
Plug 'sainnhe/gruvbox-material'
""""""""""""""""""""""
"  COMPLETE SEARCH   "
""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}
""""""""""""""""""""""
"  FILETYPE PLUGINS  "
""""""""""""""""""""""
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'rhysd/vim-clang-format'
Plug 'lervag/vimtex'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'frazrepo/vim-rainbow'

call plug#end()
