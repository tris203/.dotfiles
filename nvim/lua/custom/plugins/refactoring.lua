return {
  'ThePrimeagen/refactoring.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('telescope').load_extension 'refactoring'
    require('refactoring').setup {}
    vim.keymap.set({ 'n', 'x' }, '<leader>re',
      '<esc><CR><cmd>lua require("telescope").extensions.refactoring.refactors()<CR>', { desc = 'Refactor' })
  end,
  -- keys = {
  --   {
  --     '<leader>rr',
  --     function()
  --       require('telescope').extensions.refactoring.refactors()
  --     end,
  --     { 'n', 'x' },
  --   },
  -- },
}
