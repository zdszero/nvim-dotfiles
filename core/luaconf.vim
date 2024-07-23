if has('nvim')
  lua require("nvim-treesitter.install").prefer_git = true
  lua require('plugins/treesitter')
  lua require('plugins/indent-blankline')
endif

if g:config["nvim_lsp_support"] == 1
  lua require('plugins/telescope')
  lua require('plugins/cmp')
  lua require('plugins/lspconfig')
  lua require('plugins/nvim-tree')
  lua require('plugins/lualine')
  lua require("nvim-autopairs").setup{}
  lua require("symbols-outline").setup{}
endif
