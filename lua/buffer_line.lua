vim.opt.termguicolors = true
require("bufferline").setup{}

M = {}

local options = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', ']t', '<cmd>BufferLineMoveNext<CR>', options)
vim.api.nvim_set_keymap('n', '[t', '<cmd>BufferLineMovePrev<CR>', options)
vim.api.nvim_set_keymap('n', ']b', '<cmd>BufferLineCycleNext<CR>', options)
vim.api.nvim_set_keymap('n', '[b', '<cmd>BufferLineCyclePrev<CR>', options)

function M.delete_buffer()
  local bufnum = vim.fn.bufnr()
  vim.cmd('BufferLineCyclePrev')
  vim.cmd('bdelete ' .. bufnum)
end

vim.api.nvim_set_keymap('n', '<F1>', '<cmd>lua require"buffer_line".delete_buffer()<CR>', { noremap = true })
vim.cmd[[
  command! BD :lua require"buffer_line".delete_buffer()
]]

return M
