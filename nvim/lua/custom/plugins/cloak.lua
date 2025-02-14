return {
  'laytan/cloak.nvim',
  event = 'UIEnter',
  opts = {
    cloak_length = 30,
  },
  keys = {
    { '<leader>ct', '<cmd>CloakToggle<cr>', desc = 'Toggle Cloak' },
  },
}
