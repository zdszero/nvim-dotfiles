lua<<EOF
require('formatter').setup({
filetype = {
  javascript = {
    -- prettier
    function()
      return {
        exe = "prettier",
        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
        stdin = true
      }
    end
  },
  python = {
    -- autopep8
    function()
      return {
        exe = 'autopep8',
        args = {vim.api.nvim_buf_get_name(0)},
        stdin = true
      }
    end
  },
  cpp = {
      -- clang-format
     function()
        return {
          exe = "clang-format",
          args = {"--style=\"{BasedOnStyle: LLVM, IndentWidth: 2}\"", "--assume-filename", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
        }
      end
  },
  c = {
      -- clang-format
     function()
        return {
          exe = "clang-format",
          args = {"--style=\"{BasedOnStyle: LLVM, IndentWidth: 2}\"", "--assume-filename", vim.api.nvim_buf_get_name(0)},
          stdin = true,
          cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
        }
      end
  },
}
})
EOF

function! s:FormatCode()
  let v:errmsg = ''
  silent! Format
  if v:errmsg == ''
    return
  endif
  call CocAction('format')
endfunction

nmap <leader>f :call <SID>FormatCode()<CR>
