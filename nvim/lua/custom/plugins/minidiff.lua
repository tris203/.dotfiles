return {
  {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    config = function()
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = {
            add = '┃',
            change = '┃',
            delete = '_',
          },
        },
      }
    end,
  },
}
