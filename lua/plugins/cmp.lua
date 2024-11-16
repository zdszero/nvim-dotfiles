local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local snippy = require("snippy")

local cmp = require("cmp")

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('snippy').expand_snippet(args.body) -- For `snippy` users.
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i','c'}),
    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i','c'}),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif snippy.can_expand() then 
          snippy.expand()
        else
          fallback()
        end
      end
    ),
    ["<C-j>"] = cmp.mapping(
      function(fallback)
        if snippy.can_jump(1) then
          snippy.next()
        else
          fallback()
        end
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ["<C-k>"] = cmp.mapping(
      function(fallback)
        if snippy.can_jump(-1) then
          snippy.previous()
        else
          fallback()
        end
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
  },
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'snippy' },
    { name = 'nvim_lsp', max_item_count=5, keyword_length=3, priority=90, trigger_characters={} },
    { name = 'buffer', max_item_count=2, keyword_length=3, priority=80 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
  }, {
  })
})

vim.keymap.set("i", "<C-x><C-o>", "<cmd>lua require('cmp').complete()<CR>")
