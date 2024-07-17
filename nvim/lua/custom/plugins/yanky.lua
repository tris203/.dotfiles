return {
  {
    'gbprod/yanky.nvim',
    event = 'VeryLazy',
    dependencies = {
      'kkharji/sqlite.lua',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('yanky').setup {
        highlight = {
          timer = 200.,
        },
        ring = {
          storage = 'sqlite',
        },
      }
      require('telescope').load_extension 'yank_history'
    end,
    keys = {
      { '<leader>sy', '<cmd>Telescope yank_history<CR>' },
      { 'p', '<Plug>(YankyPutAfter)', { 'x', 'n' } },
      { 'P', '<Plug>(YankyPutBefore)', { 'x', 'n' } },
      { 'gp', '<Plug>(YankyGPutAfter)', { 'x', 'n' } },
      { 'gP', '<Plug>(YankyGPutNefore)', { 'x', 'n' } },
      { '<C-p>', '<Plug>(YankyPreviousEntry)' },
      { '<C-n>', '<Plug>(YankyNextEntry)' },
    },
  },
  {
    'gbprod/cutlass.nvim',
    event = 'UIEnter',
    opts = {
      cut_key = 'm',
    },
  },
}
