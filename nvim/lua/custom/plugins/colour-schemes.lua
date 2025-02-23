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
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    opts = {
      disable_background = true,
      disable_float_background = true,
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },
  {
    'scottmckendry/cyberdream.nvim',
    name = 'cyberdream',
    lazy = true,
    opts = {
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      borderless_pickers = false,
      terminal_colors = true,
    },
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    config = function()
      require('kanagawa').setup {
        transparent = true,
        dimInactive = true,

        overrides = function(_colors)
          -- local _theme = colors.theme
          return {
            NormalFloat = { bg = 'none' },
            FloatBorder = { bg = 'none' },
            FloatTitle = { bg = 'none' },
          }
        end,
      }
    end,
  },
  {
    'darkvoid-theme/darkvoid.nvim',
    lazy = true,
    opts = {
      transparent = true,
      glow = true,
    },
  },
  {
    '0xstepit/flow.nvim',
    opts = {
      theme = {
        transparent = true,
      },
    },
  },
}
