let g:config_dir = expand("<sfile>:p:h")

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

fun! s:conditional_load()
  if g:config['markdown_support'] == 1
    let g:vim_markdown_wiki_rtp = g:config_dir..'/'..'vimwiki-markdown'
    let g:vim_hugo_rtp = g:config_dir..'/'..'vim-hugo'
    let &rtp = join([&rtp, g:vim_markdown_wiki_rtp, g:vim_hugo_rtp], ',')
    let &packpath = &rtp
  endif

  if g:config['coc_support'] == 1
    call LoadConfig('core/coc.vim')
    call LoadConfig('core/fzf.vim')
  endif

  if has('nvim')
    call LoadConfig('core/luaconf.vim')
  endif
endfun

call s:parse_conf()
call LoadConfig('core/option.vim')
call LoadConfig('core/keymap.vim')
call LoadConfig('core/command.vim')
call LoadConfig('core/plugin.vim')
call LoadConfig('core/util.vim')
call s:conditional_load()
