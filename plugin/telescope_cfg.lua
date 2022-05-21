require('telescope').setup{
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    git_files = {
      theme = "dropdown"
    },
    help_tags = {
      theme = "dropdown"
    },
  },
}
require('telescope').load_extension('coc')

vim.keymap.set("n", "<leader>sf", function()
  vim.cmd("silent !git rev-parse --is-inside-work-tree")
  local shell_error = vim.api.nvim_get_vvar('shell_error')
  if shell_error == 0 then
    require('telescope.builtin').git_files()
  else
    require('telescope.builtin').find_files()
  end
end)
vim.keymap.set("n", "<leader>sn", "<cmd>lua require('telescope.builtin').find_files({search_dirs={vim.g.config_dir}})<CR>")
vim.keymap.set("n", "<leader>sl", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>")
vim.keymap.set("n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<CR>")
vim.keymap.set("n", "<leader>sC", "<cmd>lua require('telescope.builtin').commands()<CR>")
vim.keymap.set("n", "<leader>sh", "<cmd>lua require('telescope.builtin').help_tags()<CR>")
vim.keymap.set("n", "<leader>so", "<cmd>Telescope coc document_symbols theme=get_dropdown<CR>")
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope coc commands theme=get_dropdown<CR>")
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope coc diagnostics theme=get_dropdown<CR>")
vim.keymap.set("n", "gr", "<cmd>Telescope coc references theme=get_dropdown<CR>")
