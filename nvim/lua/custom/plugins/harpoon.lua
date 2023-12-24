return {
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    -- dir = "/home/tris/code/harpoon",
    event = 'VeryLazy',
    config = function()
      local harpoon = require 'harpoon'

      -- harpoon2 keybinds
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():append()
      end)

      vim.keymap.set('n', '<leader>h', function()
        harpoon.ui:toggle_quick_menu(harpoon:list 'tmux')
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<C-t>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<C-h>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<C-n>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<C-b>', function()
        harpoon:list():select(4)
      end)

      harpoon:setup {
        default = {},
      }
    end,

    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
}
