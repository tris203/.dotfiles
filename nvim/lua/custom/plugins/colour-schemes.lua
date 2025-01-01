return {
  -- {
  --   'vague2k/huez.nvim',
  --   -- import = 'huez-manager.import',
  --   priority = 1000,
  --   event = 'UIEnter',
  --   dependencies = {
  --     'nvim-telescope/telescope.nvim',
  --   },
  --   -- event = 'UIEnter',
  --   -- config = function()
  --   --   local scheme = require('huez.api').colorscheme.get()
  --   --   -- local scheme = 'tokyonight'
  --   --   vim.cmd('colorscheme ' .. scheme)
  --   -- end,
  --   opts = {},
  --   keys = {
  --     {
  --       '<leader>hh',
  --       '<cmd>Huez<CR>',
  --       desc = 'Change colorscheme',
  --     },
  --     {
  --       '<leader>hl',
  --       '<cmd>HuezLive<CR>',
  --       desc = 'View Registry',
  --     },
  --   },
  -- },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup {
        transparent = true,
        -- on_colors = function(colors)
        --   ---@diagnostic disable-next-line: inject-field
        --   -- colors.fg_gutter = '#b2b8cf'
        -- end,
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
      }
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
      borderless_telescope = false,
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
}
