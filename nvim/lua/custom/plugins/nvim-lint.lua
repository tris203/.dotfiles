return {
  'mfussenegger/nvim-lint',
  enabled = false,
  event = 'VeryLazy',
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { 'eslint' },
      javascriptreact = { 'eslint' },
      lua = { 'luacheck' },
    }
  end,
}
