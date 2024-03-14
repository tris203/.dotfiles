return {
  'laytan/cloak.nvim',
  event = 'BufRead',
  opts = {
    cloak_length = 30,
  },
  keys = {
    { '<leader>ct', '<cmd>CloakToggle<cr>' },
  },
}
