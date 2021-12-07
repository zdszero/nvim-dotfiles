""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Telescope                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction

lua << EOF
require('telescope').setup{
  defaults = {
    layout_config = {
      center = {
        preview_cutoff = 40
      },
      height = 0.75,
      horizontal = {
        preview_cutoff = 120,
        prompt_position = "bottom"
      },
      vertical = {
        preview_cutoff = 40
      },
      width = 0.8
    }
  }
}
require('telescope').load_extension('coc')
EOF

function! s:is_in_git_directory()
  silent !git rev-parse --is-inside-work-tree
  if v:shell_error == 0
    return 1
  endif
  return 0
endfunction


nmap <silent> gr :Telescope coc references<cr>
nmap <silent> <leader>sd :Telescope coc diagnostics<cr>
nmap <silent> <leader>so :Telescope coc document_symbols<cr>

nmap <silent> <expr> <leader>sf <SID>is_in_git_directory() ?
      \'<cmd>Telescope git_files theme=get_dropdown<cr>' : '<cmd>Telescope find_files theme=get_dropdown<cr>'
nmap <silent> <leader>sb :Telescope buffers theme=get_dropdown<cr>
nmap <silent> <leader>st :Telescope colorscheme theme=get_dropdown<cr>
nmap <silent> <leader>sl :Telescope current_buffer_fuzzy_find<cr>
nmap <silent> <leader>sg :Telescope live_grep<cr>
nmap <silent> <leader>sc :Telescope commands<cr>
nmap <silent> <leader>sh :Telescope help_tags<cr>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" wildfire
map ge <Plug>(wildfire-fuel)
" vista
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_close_on_jump=0
let g:vista#renderer#enable_icon = 1


let g:hugo_home_path = '~/Documents/blog'
let g:hugo_post_template = [
      \ '---',
      \ 'title: HUGO_TITLE',
      \ 'date: HUGO_DATE',
      \ 'tags: []',
      \ 'draft: true',
      \ '---',
      \ '' ]
let g:hugo_build_script_path = '~/Documents/blog/update_blog'

