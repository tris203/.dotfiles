return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    event = 'UIEnter',
    config = function()
      require('tokyonight').setup {
        transparent = true,
        on_colors = function(colors)
          ---@diagnostic disable-next-line: inject-field
          colors.fg_gutter = '#b2b8cf'
        end,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
      vim.cmd 'colorscheme tokyonight'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    event = 'VeryLazy',
    opts = {
      disable_background = true,
      disable_float_background = true,
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'VeryLazy',
    opts = {
      transparent_background = true,
    },
  },
}
