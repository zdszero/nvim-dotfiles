require('telescope').setup{
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    git_files = {
      theme = "dropdown"
    },
    buffers = {
      theme = 'dropdown',
    },
    help_tags = {
      theme = "dropdown"
    },
    lsp_document_symbols = {
      theme = 'dropdown'
    },
    commands = {
      theme = 'dropdown'
    },
    lsp_references = {
      theme = 'ivy'
    },
    diagnostics = {
      theme = 'ivy'
    },
    current_buffer_fuzzy_find = {
      theme = 'ivy'
    },
    live_grep = {
      theme = 'ivy'
    },
  },
}
vim.keymap.set("n", "<leader>sf", function()
  vim.cmd("silent !git rev-parse --is-inside-work-tree")
  local shell_error = vim.api.nvim_get_vvar('shell_error')
  if shell_error == 0 then
    require('telescope.builtin').git_files()
  else
    require('telescope.builtin').find_files()
  end
end)
vim.g.initial_dir=vim.fn.getcwd()
vim.keymap.set("n", "<leader>sn", "<cmd>lua require('telescope.builtin').find_files({cwd=vim.g.config_dir})<CR>")
vim.keymap.set("n", "<leader>sb", "<cmd>lua require('telescope.builtin').buffers()<CR>")
vim.keymap.set("n", "<leader>sl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
vim.keymap.set("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep({cwd=vim.g.initial_dir})<CR>")
vim.keymap.set("n", "<leader>sC", "<cmd>lua require('telescope.builtin').commands()<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
vim.keymap.set("n", "<leader>so", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>")
vim.keymap.set("n", "<leader>sd", "<cmd>lua require('telescope.builtin').diagnostics()<CR>")
vim.keymap.set("n", "<leader>sc", "<cmd>lua require('telescope.builtin').commands()<CR>")
vim.keymap.set("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>")

vim.keymap.set("n", "<leader>ws", function()
  require('telescope.builtin').find_files({
    search_dirs={vim.g.wiki_config['home'] .. '/' .. vim.g.wiki_config['markdown_dir']}
  })
end)
