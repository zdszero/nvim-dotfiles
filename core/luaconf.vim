if has('nvim')
  lua require('plugins/buffer-line')
  if g:config['treesitter_support'] == 1
    lua require('plugins/treesitter')
  endif
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
