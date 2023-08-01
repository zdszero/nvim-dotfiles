let g:config_dir = expand("<sfile>:p:h")

fun LoadConfig(filename)
  exe 'so ' . g:config_dir..'/'..a:filename
endfun

fun EditConfig(filename)
  exe 'edit ' . g:config_dir..'/'..a:filename
endfun

fun! ParseConfigFile()
  let g:config_file = g:config_dir . '/editor.conf'
  if filereadable(g:config_file)
    let g:config = {}
    let lines = readfile(g:config_file)
    for line in lines
      if line =~# '^#'
        continue
      endif
      let parts = split(line, '=')
      if len(parts) == 2
        let key = trim(parts[0])
        let value = trim(parts[1])
        let g:config[key] = value
      endif
    endfor
  endif
endfun

call ParseConfigFile()

call LoadConfig('option.vim')
call LoadConfig('keymap.vim')
call LoadConfig('command.vim')
call LoadConfig('plugin.vim')
call LoadConfig('util.vim')

if g:config['markdown_support'] == 1
  let g:vim_markdown_wiki_rtp = g:config_dir..'/'..'vimwiki-markdown'
  let g:vim_hugo_rtp = g:config_dir..'/'..'vim-hugo'
  let &rtp = join([&rtp, g:vim_markdown_wiki_rtp, g:vim_hugo_rtp], ',')
  let &packpath = &rtp
endif

if g:config['coc_support'] == 1
  call LoadConfig('coc.vim')
  call LoadConfig('fzf.vim')
endif

if g:config['lua_support'] == 1
  lua require('bufferline').setup{}
  lua require('plugins/treesitter')
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
