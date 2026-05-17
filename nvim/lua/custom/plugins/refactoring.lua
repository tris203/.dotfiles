return {
  'ThePrimeagen/refactoring.nvim',
  branch = '1.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {},
  keys = {
    {
      '<leader>re',
      function()
        require('refactoring').select_refactor {}
      end,
      { 'n', 'x' },
    },
  },
}
