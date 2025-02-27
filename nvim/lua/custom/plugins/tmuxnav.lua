-- vim.keymap.set('n', "<m-,>", "<C-w>5<")tmux
-- vim.keymap.set('n', "<m-.>", "<C-w>5>")
--
return {
  -- 'christoomey/vim-tmux-navigator',
  -- cmd = {
  --   'TmuxNavigateLeft',
  --   'TmuxNavigateDown',
  --   'TmuxNavigateUp',
  --   'TmuxNavigateRight',
  --   'TmuxNavigatePrevious',
  --   'TmuxNavigatorProcessList',
  -- },
  -- keys = {
  --   { '<m-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'tmux Left' },
  --   { '<m-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'tmux down' },
  --   { '<m-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'tmux up' },
  --   { '<m-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'tmux right' },
  -- },

  {
    'mrjones2014/smart-splits.nvim',
    -- event = 'VeryLazy',
    opts = {},
    config = function(_, opts)
      require('smart-splits').setup(opts)
      vim.keymap.set('n', '<m-h>', require('smart-splits').move_cursor_left)
      vim.keymap.set('n', '<m-j>', require('smart-splits').move_cursor_down)
      vim.keymap.set('n', '<m-k>', require('smart-splits').move_cursor_up)
      vim.keymap.set('n', '<m-l>', require('smart-splits').move_cursor_right)

      vim.keymap.set('n', '<c-h>', require('smart-splits').resize_left)
      vim.keymap.set('n', '<c-j>', require('smart-splits').resize_down)
      vim.keymap.set('n', '<c-k>', require('smart-splits').resize_up)
      vim.keymap.set('n', '<c-l>', require('smart-splits').resize_right)
    end,
  },
  -- keys = {
  --   {
  --     '<m-h>',
  --     function()
  --       require('smart-splits').move_cursor_left()
  --     end,
  --     desc = 'tmux Left',
  --   },
  --   {
  --     '<m-j>',
  --     function()
  --       require('smart-splits').move_cursor_down()
  --     end,
  --     desc = 'tmux down',
  --   },
  --   {
  --     '<m-k>',
  --     function()
  --       require('smart-splits').move_cursor_up()
  --     end,
  --     desc = 'tmux up',
  --   },
  --   {
  --     '<m-l>',
  --     function()
  --       require('smart-splits').move_cursor_right()
  --     end,
  --     desc = 'tmux right',
  --   },
  -- },
}
