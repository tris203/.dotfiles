return {
  'willothy/nvim-cokeline',
  event = 'UIEnter',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for v0.4.0+
    'kyazdani42/nvim-web-devicons', -- If you want devicons
    'stevearc/resession.nvim', -- Optional, for persistent history
  },
  config = true,
}
