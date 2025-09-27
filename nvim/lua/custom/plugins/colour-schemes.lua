return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    opts = {
      transparent = true,
      on_colors = function(colors)
        ---@diagnostic disable-next-line: inject-field
        -- colors.fg_gutter = '#b2b8cf'
        colors.border = '#b2b8cf'
      end,
      on_highlights = function(hl, _colors)
        hl.Folded = {
          link = 'Normal',
        }
        hl.LspInlayHint = {
          link = 'Comment',
        }
      end,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      vim.cmd 'colorscheme tokyonight'
    end,
  },
  {
    'scottmckendry/cyberdream.nvim',
    name = 'cyberdream',
    event = 'VeryLazy',
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = false,
      terminal_colors = true,
    },
  },
  {
    'darkvoid-theme/darkvoid.nvim',
    event = 'VeryLazy',
    opts = {
      transparent = true,
      glow = true,
    },
  },
}
