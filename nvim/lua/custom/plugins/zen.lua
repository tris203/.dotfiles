return {
  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    keys = { { '<leader>z', '<cmd>ZenMode<cr>' } },
    opts = {
      window = {
        width = 0.6,
        options = {
          signcolumn = 'no', -- disable signcolumn
        },
      },
      plugins = {
        tmux = { enabled = true },
      },
    },
  },
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightEnable' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
}
