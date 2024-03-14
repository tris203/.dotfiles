local harpoon
return {
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dev = false,
    config = function()
      harpoon = require 'harpoon'
      harpoon:setup {}
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '<leader>a',
        function()
          harpoon:list():append()
        end,
      },
      {
        '<C-e>',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
      },
      {
        '<C-x>',
        function()
          harpoon:list():select(1)
        end,
      },
      {
        '<C-h>',
        function()
          harpoon:list():select(2)
        end,
      },
      {
        '<C-n>',
        function()
          harpoon:list():select(3)
        end,
      },
      {
        '<C-b>',
        function()
          harpoon:list():select(4)
        end,
      },
    },
  },
}
