local cmp = require'cmp'

vim.g.UltiSnipsExpandTrigger = '<Plug>(ultisnips_expand)'      
vim.g.UltiSnipsJumpForwardTrigger = '<Plug>(ultisnips_jump_forward)'
vim.g.UltiSnipsJumpBackwardTrigger = '<Plug>(ultisnips_jump_backward)'
vim.g.UltiSnipsListSnippets = '<c-x><c-s>'
vim.g.UltiSnipsRemoveSelectModeMappings = 0

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function is_expandable()
  local col = vim.fn.col('.')
  local line = vim.fn.getline('.')
  local snips_in_scope = vim.fn['UltiSnips#SnippetsInCurrentScope']

  if col <= 1 then
    return false
  end

  local char_before_cursor = line:sub(col - 1, col - 1)
  if char_before_cursor:match('%s') then
    return false
  end

  if vim.tbl_isempty(snips_in_scope()) then
    return false
  end

  return true
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        elseif is_expandable() then 
          vim.api.nvim_feedkeys( t("<Plug>(ultisnips_expand)"), 'm', true)
        else
          fallback()
        end
      end
    ),
    ["<C-j>"] = cmp.mapping(
      function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
    ["<C-k>"] = cmp.mapping(
      function(fallback)
        if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
          vim.api.nvim_feedkeys( t("<Plug>(ultisnips_jump_backward)"), 'm', true)
        else
          fallback()
        end
      end,
      { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
    ),
  }),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'ultisnips', max_item_count=2, keyword_length=2, priority=100 },
    { name = 'nvim_lsp', max_item_count=5, keyword_length=3, priority=90, trigger_characters={} },
    { name = 'buffer', max_item_count=2, keyword_length=3, priority=80 },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
  }, {
  })
})

vim.keymap.set("i", "<C-x><C-o>", "<cmd>lua require('cmp').complete()<CR>")
