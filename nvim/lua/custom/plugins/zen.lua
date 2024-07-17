return {
  {
    'folke/zen-mode.nvim',
    cmd = { 'ZenMode' },
    keys = { { '<leader>z', '<cmd>ZenMode<cr>', desc = '[Z]en Mode' } },
    --- @module "zen-mode"
    --- @type ZenOptions
    opts = {
      window = {
        width = 0.6,
        options = {
          signcolumn = 'no', -- disable signcolumn
        },
      },
      plugins = {
        tmux = { enabled = true },
        twilight = { enabled = true },
      },
    },
  },
  {
    'folke/twilight.nvim',
    cmd = { 'Twilight', 'TwilightEnable' },
    --- @module "twilight"
    --- @type TwilightOptions
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        'function',
        'method',
        'table',
        'if_statement',
        'function_declaration',
        'method_declaration',
        'comment',
      },
    },
  },
}
