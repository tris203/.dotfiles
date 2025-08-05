return {
  {
    'gbprod/yanky.nvim',
    vscode = true,
    event = 'VeryLazy',
    dependencies = {
      {
        'kkharji/sqlite.lua',
        vscode = true,
      },
    },
    opts = {
      highlight = {
        timer = 200.,
      },
      ring = {
        storage = 'sqlite',
      },
    },
    keys = {
      { 'p', '<Plug>(YankyPutAfter)', { 'x', 'n' } },
      { 'P', '<Plug>(YankyPutBefore)', { 'x', 'n' } },
      { 'gp', '<Plug>(YankyGPutAfter)', { 'x', 'n' } },
      { 'gP', '<Plug>(YankyGPutNefore)', { 'x', 'n' } },
      { '<C-p>', '<Plug>(YankyPreviousEntry)' },
      { '<C-n>', '<Plug>(YankyNextEntry)' },
      {
        '<leader>sy',
        function()
          ---@diagnostic disable-next-line: undefined-field
          Snacks.picker.yanky()
        end,
      },
    },
  },
  {
    'gbprod/cutlass.nvim',
    event = 'UIEnter',
    vscode = true,
    opts = {
      exclude = { 'ns', 'nS' },
    },
    config = function(_, opts)
      require('cutlass').setup(opts)

      local cut_key = 'm'
      vim.keymap.set('n', cut_key, 'd', { noremap = true, silent = true })
      vim.keymap.set('x', cut_key, 'd', { noremap = true, silent = true })
      vim.keymap.set('n', cut_key .. cut_key, 'dd', { noremap = true, silent = true })
    end,
  },
}
