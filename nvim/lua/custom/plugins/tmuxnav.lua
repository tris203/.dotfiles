vim.keymap.set('n', "<m-,>", "<C-w>5<")
vim.keymap.set('n', "<m-.>", "<C-w>5>")

return {
  'christoomey/vim-tmux-navigator',
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>',  '<cmd><C-U>TmuxNavigateLeft<cr>' },
    { '<C-j>',  '<cmd><C-U>TmuxNavigateDown<cr>' },
    { '<C-k>',  '<cmd><C-U>TmuxNavigateUp<cr>' },
    { '<C-l>',  '<cmd><C-U>TmuxNavigateRight<cr>' },
    { '<C-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  },
}
