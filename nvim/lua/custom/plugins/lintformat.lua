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
        'TextChanged',
        'BufWritePost',
      }, {
        group = group,
        callback = function()
          local progress = require('fidget').progress.handle.create {
            message = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t'),
            title = 'Linting',
            lsp_client = {
              name = 'conform',
            },
            cancellable = false,
            done = false,
          }
          lint.try_lint()
          progress:finish()
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
        javascript = { 'prettierd', 'eslint_d' },
        typescript = { 'prettierd', 'eslint_d' },
        typescriptreact = { 'prettierd', 'eslint_d' },
        tsx = { 'prettierd', 'eslint_d' },
        css = { 'prettierd', 'eslint_d' },
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
          local progress = require('fidget').progress.handle.create {
            message = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t'),
            title = 'Formatting',
            lsp_client = {
              name = 'conform',
            },
            cancellable = false,
            done = false,
          }
          require('conform').format({ async = true }, function()
            progress:finish()
          end)
        end,
        desc = 'Format Buffer',
      },
    },
  },
}
