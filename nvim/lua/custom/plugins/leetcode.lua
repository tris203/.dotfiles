return {
  {
    'kawre/leetcode.nvim',
    dependencies = {
      -- 'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
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
