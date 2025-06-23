return {
  {
    'echasnovski/mini.diff',
    event = 'VeryLazy',
    config = function()
      local diff = require 'mini.diff'
      diff.setup {
        -- Disabled by default
        source = diff.gen_source.none(),
      }
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
