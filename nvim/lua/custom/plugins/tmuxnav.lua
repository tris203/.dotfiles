-- vim.keymap.set('n', "<m-,>", "<C-w>5<")tmux
-- vim.keymap.set('n', "<m-.>", "<C-w>5>")
--
return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
    'TmuxNavigatorProcessList',
  },
  keys = {
    { '<m-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'tmux Left' },
    { '<m-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'tmux down' },
    { '<m-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'tmux up' },
    { '<m-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'tmux right' },
  },
}
