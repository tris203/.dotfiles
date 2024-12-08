return {
  {
  'ThePrimeagen/vim-apm',
  enabled = false,
  event = 'VeryLazy',
  config = function()
    local vimapm = require 'vim-apm'
    vimapm:setup {}
    vimapm:toggle_monitor()
  end,
  },
  {
  'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  }
}
