return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufWritePost', 'BufReadPost', 'InsertLeave' },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        lua = { 'luacheck' },
        markdown = { 'proselint' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        tsx = { 'eslint_d' },
      }
      local group = vim.api.nvim_create_augroup('nvim-lint_au', { clear = true })

      vim.api.nvim_create_autocmd({
        'TextChangedI',
        'InsertLeave',
      }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.api.nvim_create_autocmd({
        'TextChanged',
        'BufWritePost',
      }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'nixpkgs-fmt' },
        c = { 'uncrustify', 'clang-format' },
        rust = { 'rustfmt' },
        javascript = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        tsx = { 'prettierd' },
        css = { 'prettierd' },
        html = { 'prettierd' },
        markdown = { 'markdownlint', 'prettierd' },
      },
      default_format_opts = {
        lsp_format = 'fallback',
      },
      formatters = {
        uncrustify = {
          env = {
            UNCRUSTIFY_CONFIG = vim.fn.getcwd() .. '/src/uncrustify.cfg',
          },
        },
      },
    },
    keys = {
      {
        '<leader>lf',
        function()
          require('conform').format { async = true }
        end,
        desc = 'Format Buffer',
      },
    },
  },
}
