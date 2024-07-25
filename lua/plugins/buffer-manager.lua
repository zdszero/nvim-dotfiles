local map = vim.keymap.set

require('buffer_manager').setup({
  short_file_names = true
})

map('n', "<C-n>", ":lua require('buffer_manager.ui').toggle_quick_menu()<CR>")
