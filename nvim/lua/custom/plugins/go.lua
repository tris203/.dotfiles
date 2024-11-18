return {
  {
    'ray-x/go.nvim',
    -- commit = '81d8d0d90d3f6bcb44181800da3ed43356a26c1b',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup {
        lsp_cfg = true,
        lsp_on_attach = require 'lspattach',
        lsp_inlay_hints = { enable = false },
        trouble = true,
      }
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
  },
}
