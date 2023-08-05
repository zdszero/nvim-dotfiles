if g:config['lua_support'] == 1
  lua require('bufferline').setup{}
  " lua require('plugins/treesitter')
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
