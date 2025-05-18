return {
  {
    'ray-x/go.nvim',
    -- commit = '37ec4d9be3edef64b725bfe29684e1fe019873bc',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },

    opts = {
      lsp_cfg = true,
      lsp_on_attach = require 'lspattach',
      lsp_inlay_hints = { enable = false },
      trouble = true,
      diagnostic = false,
      remap_commands = { GoDoc = false },
      textobjects = false,
    },
    config = function(_, opts)
      require('go').setup(opts)
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
  },
  {
    'fredrikaverpil/godoc.nvim',
    dependencies = {
      { 'folke/snacks.nvim' },
      {
        'nvim-treesitter/nvim-treesitter',
        opts = {
          ensure_installed = { 'go' },
        },
      },
    },
    build = 'go install github.com/lotusirous/gostdsym/stdsym@latest', -- optional
    cmd = { 'GoDoc' },
    opts = {
      picker = {
        type = 'snacks',
      },
    },
  },
  {
    'maxandron/goplements.nvim',
    ft = 'go',
    opts = {},
  },
}
