-- vim.o.wrap = true
vim.o.textwidth = 80
vim.o.conceallevel = 2

vim.api.nvim_set_option_value('formatexpr', '', { buf = vim.api.nvim_get_current_buf() })

-- Use internal formatting for bindings like gq.
vim.api.nvim_create_autocmd('LspAttach', {
  pattern = '*.md',
  callback = function(args)
    vim.bo[args.buf].formatexpr = nil
  end,
})
