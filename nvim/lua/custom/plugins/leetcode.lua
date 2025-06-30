return {
  {
    'kawre/leetcode.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',

      -- optional

      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.icons',
    },
    opts = {
      plugins = {
        non_standalone = true,
      },
      injector = {
        golang = {
          before = 'package main',
        },
      },
    },
    cmd = 'Leet',
  },
  -- {
  --   'nvzone/typr',
  --   cmd = { 'TyprStats', 'Typr' },
  --   dependencies = 'nvzone/volt',
  --   opts = {},
  -- },
}
