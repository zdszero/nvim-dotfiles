-- vim.opt.termguicolors = true
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

-- vim.g.indent_blankline_char = '•'
vim.g.indent_blankline_space_char_blankline = ' '
-- vim.g.indent_blankline_filetype = {'python', 'go'}
vim.g.indent_blankline_filetype_exclude = {'startify', 'coc-explorer', 'cmake', 'c', 'cpp'}
vim.g.indent_blankline_buftype_exclude = {'terminal', 'help'}

require("indent_blankline").setup {}
