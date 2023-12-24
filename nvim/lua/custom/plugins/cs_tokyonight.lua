return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      transparent = true,
      on_colors = function(colors)
        colors.fg_gutter = '#b2b8cf'
      end,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
  },
}
