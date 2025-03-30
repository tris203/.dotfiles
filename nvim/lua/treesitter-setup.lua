-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_install = {
      'c',
      'c_sharp',
      'html',
      'html_tags',
      'razor',
      'markdown',
      'markdown_inline',
      'cpp',
      'go',
      'lua',
      'python',
      'rust',
      'tsx',
      'javascript',
      'typescript',
      'vimdoc',
      'vim',
      'bash',
      'markdown_inline',
      'regex',
      'html',
      'vue',
    },
  }

  local group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true })

  local syntax_on = {
    -- filetypes to use vim syntax highlighting for
  }

  local ts_off = {
    checkhealth = true,
  }

  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    callback = function(args)
      local bufnr = args.buf
      local ft = vim.bo[bufnr].filetype

      if ts_off[ft] then
        return
      end
      local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
      if not ok or not parser then
        return
      end
      pcall(vim.treesitter.start)

      if syntax_on[ft] then
        vim.bo[bufnr].syntax = 'on'
      end
    end,
  })
end, 0)

local parser_config = require 'nvim-treesitter.parsers'

parser_config.blade = {
  tier = 0,
  install_info = {
    url = 'https://github.com/EmranMR/tree-sitter-blade',
    files = { 'src/parser.c' },
    branch = 'main',
  },
  filetype = 'blade',
}

-- vim: ts=2 sts=2 sw=2 et
