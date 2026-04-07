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

      local lint_exclude_ft = {}

      lint.linters.eslint_d = require('lint.util').wrap(lint.linters.eslint_d, function(diagnostic)
        if diagnostic.message:find 'Error: Could not find config file' then
          return nil
        end

        return diagnostic
      end)

      vim.api.nvim_create_autocmd({
        'TextChangedI',
        'InsertLeave',
        'TextChanged',
        'BufWritePost',
      }, {
        group = group,
        callback = function(ev)
          if lint_exclude_ft[vim.bo[ev.buf].filetype] then
            return
          end
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
          local id = vim.api.nvim_echo(
            { { 'Formatting started...' } },
            true,
            { kind = 'progress', status = 'running', percent = 10, title = 'conform', source = 'format' }
          )
          require('conform').format { async = true }
          vim.api.nvim_echo(
            { { 'Formatting complete.' } },
            true,
            { id = id, kind = 'progress', status = 'success', percent = 100, title = 'conform', source = 'format' }
          )
        end,
        desc = 'Format Buffer',
      },
    },
  },
}
