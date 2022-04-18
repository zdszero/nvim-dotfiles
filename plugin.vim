let s:plug_dir = g:config_dir . 'plugged'

call plug#begin(s:plug_dir)

" vim enhanced
Plug 'mhinz/vim-startify'
Plug 'tweekmonster/startuptime.vim', { 'on': 'StartupTime' }
Plug 'kshenoy/vim-signature'
Plug 'lukas-reineke/indent-blankline.nvim'
" language specific
Plug 'zdszero/nvim-hugo'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/goyo.vim', {'for': 'markdown'}
Plug 'bfrg/vim-cpp-modern'
Plug 'wlangstroth/vim-racket'
Plug 'lervag/vimtex'
Plug 'rhysd/vim-clang-format'
" Plug 'fatih/vim-go'
" utilities
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vista.vim', {'on': 'Vista'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'skywind3000/asyncrun.vim'
" coding
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'gcmt/wildfire.vim'
Plug 'junegunn/vim-easy-align'
Plug 'unblevable/quick-scope'
Plug 'vimwiki/vimwiki'
" theme
Plug 'tomasiser/vim-code-dark'
Plug 'rakr/vim-one'
Plug 'sainnhe/gruvbox-material'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

call plug#end()
