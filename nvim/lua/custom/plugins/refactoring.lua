return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  epts = {},
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
