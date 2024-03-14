return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require 'null-ls'
    local builtins = null_ls.builtins

    null_ls.setup {
      debug = true,
      sources = {
        builtins.formatting.stylua,
        builtins.formatting.prettier,
        require('none-ls.formatting.eslint_d'),
        builtins.formatting.markdownlint,
        require('none-ls-luacheck.diagnostics.luacheck').with {
          args = { '--formatter', 'plain', '--codes', '--ranges', '--globals', 'vim', '--filename', '$FILENAME', '-' },
        },
        require('none-ls.diagnostics.eslint_d'),
        builtins.diagnostics.yamllint,
        builtins.diagnostics.markdownlint.with {
          extra_args = { '--disable', 'MD013' },
        },
      },
    }
  end,
  dependencies = {
    'gbprod/none-ls-luacheck.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  event = 'VeryLazy',
}
