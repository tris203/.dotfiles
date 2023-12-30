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
        builtins.formatting.markdownlint,
        builtins.diagnostics.luacheck.with {
args = { "--formatter", "plain", "--codes", "--ranges", "--globals", "vim",  "--filename", "$FILENAME", "-" }
        },
        builtins.diagnostics.eslint_d,
        builtins.diagnostics.yamllint,
        builtins.diagnostics.markdownlint,
      },
    }
  end,
  event = 'VeryLazy',
}
