return {
  'ThePrimeagen/refactoring.nvim',
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
