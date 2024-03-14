return {
  'ThePrimeagen/vim-apm',
  event = 'VeryLazy',
  config = function()
    local vimapm = require 'vim-apm'
    vimapm:setup {}
    vimapm:toggle_monitor()
  end,
}
