let s:plug_dir = g:config_dir . 'plugged'

call plug#begin(s:plug_dir)

" vim enhanced
Plug 'mhinz/vim-startify'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'kshenoy/vim-signature'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'lukas-reineke/indent-blankline.nvim'
" language specific
Plug 'zdszero/nvim-hugo'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'wlangstroth/vim-racket'
" utilities
Plug 'voldikss/vim-floaterm'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
Plug 'skywind3000/asyncrun.vim'
" coding
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhartington/formatter.nvim'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/vim-easy-align'
" theme
Plug 'Mofiqul/vscode.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'itchyny/lightline.vim'
Plug 'akinsho/bufferline.nvim'
Plug 'frazrepo/vim-rainbow'

call plug#end()

" SOURCE CONFIG FILE
execute 'source ' . g:config_dir . 'color.vim'
execute 'source ' . g:config_dir . 'coc.vim'
execute 'source ' . g:config_dir . 'format.vim'
execute 'source ' . g:config_dir . 'util.vim'
