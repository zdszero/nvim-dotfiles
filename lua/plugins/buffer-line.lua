require('bufferline').setup{}

local keyset = vim.keymap.set

function delete_buffer()
  if vim.o.modified then
    vim.cmd("bd!")
  end
  local bufnum = vim.fn.bufnr()
  vim.cmd("BufferLineCyclePrev")
  vim.cmd('bdelete ' .. bufnum)
end

keyset('n', '[b', "<cmd>BufferLineCyclePrev<CR>")
keyset('n', ']b', "<cmd>BufferLineCycleNext<CR>")
keyset('n', '[t', "<cmd>BufferLineMovePrev<CR>")
keyset('n', ']t', "<cmd>BufferLineMoveNext<CR>")
keyset('n', '<leader>d', delete_buffer)

vim.api.nvim_create_user_command('BD', delete_buffer, {})
