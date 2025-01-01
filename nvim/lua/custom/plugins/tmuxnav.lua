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
    { '<m-h>', '<cmd>TmuxNavigateLeft<cr>' },
    { '<m-j>', '<cmd>TmuxNavigateDown<cr>' },
    { '<m-k>', '<cmd>TmuxNavigateUp<cr>' },
    { '<m-l>', '<cmd>TmuxNavigateRight<cr>' },
    { '<m-\\>', '<cmd>TmuxNavigatePrevious<cr>' },
    { '<m-,>', '<C-w>5<' },
    { '<m-.>', '<C-w>5>' },
  },
}
