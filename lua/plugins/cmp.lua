local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'vsnip', max_item_count=2, keyword_length=2, priority=100 },
    { name = 'nvim_lsp', max_item_count=5, keyword_length=3, priority=90, trigger_characters={} },
    { name = 'buffer', max_item_count=2, keyword_length=3, priority=80 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
  }, {
  })
})

vim.keymap.set("i", "<C-x><C-o>", "<cmd>lua require('cmp').complete()<CR>")
