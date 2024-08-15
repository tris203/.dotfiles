return {
  {
    'ray-x/go.nvim',
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
