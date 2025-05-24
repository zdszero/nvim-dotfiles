let g:config_dir = expand("<sfile>:p:h")

function! IsWSL()
  return has('unix') && filereadable('/proc/version') &&
        \ (match(readfile('/proc/version')[0], 'Microsoft') >= 0)
endfunction

function! IsMac()
  return has('mac') || has('macunix') || system('uname') =~? '^darwin'
endfunction

function! IsWindows()
    return has('win32') || has('win64')
endfunction

fun LoadConfig(filename)
  exe 'so ' . g:config_dir..'/'..a:filename
endfun

fun EditConfig(filename)
  exe 'edit ' . g:config_dir..'/'..a:filename
endfun

fun! s:parse_conf()
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
        let g:config[key] = str2nr(value)
      endif
    endfor
  endif
endfun

call s:parse_conf()

if !has('nvim')
  let g:config['coc'] = 1
  let g:config['nvim_lsp'] = 0
endif

call LoadConfig('core/option.vim')
call LoadConfig('core/keymap.vim')
call LoadConfig('core/command.vim')
if IsWindows()
  finish
endif
call LoadConfig('core/plugin.vim')
call LoadConfig('core/util.vim')

if g:config['markdown'] == 1
  let g:vim_markdown_wiki_rtp = g:config_dir..'/'..'vimwiki-markdown'
  let g:vim_hugo_rtp = g:config_dir..'/'..'vim-hugo'
  let &rtp = join([&rtp, g:vim_markdown_wiki_rtp, g:vim_hugo_rtp], ',')
  let &packpath = &rtp
endif

if g:config['coc'] == 1 && executable('node')
  call LoadConfig('core/coc.vim')
  call LoadConfig('core/fzf.vim')
endif

if g:config["nvim_lsp"] == 1 && has('nvim')
  lua require('plugins/telescope')
  lua require('plugins/cmp')
  lua require('plugins/lspconfig')
  lua require('plugins/nvim-tree')
  lua require('plugins/gitsigns')
  lua require('plugins/snippet-converter')
  lua require("nvim-autopairs").setup{}
endif

if has('nvim')
  lua require('plugins/treesitter')
  lua require('plugins/indent-blankline')
endif
