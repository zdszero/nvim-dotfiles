require('bufferline').setup{}

function delete_buffer()
  if vim.o.modified then
    vim.cmd("bd!")
  end
  local bufnum = vim.fn.bufnr()
  vim.cmd("BufferLineCyclePrev")
  vim.cmd('bdelete ' .. bufnum)
end

vim.keymap.set('n', '[b', "<cmd>BufferLineCyclePrev<CR>")
vim.keymap.set('n', ']b', "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set('n', '[t', "<cmd>BufferLineMovePrev<CR>")
vim.keymap.set('n', ']t', "<cmd>BufferLineMoveNext<CR>")
vim.keymap.set('n', '<leader>d', delete_buffer)

vim.api.nvim_create_user_command('BD', delete_buffer, {})
