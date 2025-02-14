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
      exclude = { 'ns', 'nS' },
    },
    config = function(_, opts)
      require('cutlass').setup(opts)

      local keymap_opts = { noremap = true, silent = true }
      local cut_key = 'm'
      vim.keymap.set('n', cut_key, 'd', keymap_opts)
      vim.keymap.set('x', cut_key, 'd', keymap_opts)
      vim.keymap.set('n', cut_key .. cut_key, 'dd', keymap_opts)
    end,
  },
}
