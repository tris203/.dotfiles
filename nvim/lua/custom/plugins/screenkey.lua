return {
  'NStefan002/screenkey.nvim',
  keys = {
    {
      '<leader>sk',
      function()
        require('screenkey').toggle()
      end,
      desc = 'Toggle Screenkey',
    },
  },
}
