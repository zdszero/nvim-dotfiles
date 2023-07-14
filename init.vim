fun LoadConfig(filename)
  exe 'so ' . g:config_dir..'/'..a:filename
endfun

fun EditConfig(filename)
  exe 'edit ' . g:config_dir..'/'..a:filename
endfun

let g:config_dir = expand("<sfile>:p:h")
let g:vim_markdown_wiki_rtp = g:config_dir..'/'..'vim-markdown-wiki'
let g:vim_hugo_rtp = g:config_dir..'/'..'vim-hugo'
let &rtp = join([&rtp, g:vim_markdown_wiki_rtp, g:vim_hugo_rtp], ',')
let &packpath = &rtp

call LoadConfig('option.vim')
call LoadConfig('keymap.vim')
call LoadConfig('command.vim')
call LoadConfig('plugin.vim')
call LoadConfig('color.vim')
call LoadConfig('coc.vim')
call LoadConfig('fzf.vim')
call LoadConfig('util.vim')

if has("nvim")
  " lua require('plugins/telescope')
  lua require('plugins/treesitter')
endif
