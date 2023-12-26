local schemes = {
  'folke/tokyonight.nvim',
  'rose-pine/neovim',
  'catppuccin/nvim',
}
--[[ math.randomseed(os.time())
local random_theme = schemes[math.random(#schemes)] ]]

local random_theme = schemes[1]

return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    event = 'UIEnter',
    config = function()
      require('tokyonight').setup {
        transparent = true,
        on_colors = function(colors)
          colors.fg_gutter = '#b2b8cf'
        end,
        styles = {
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }
      if random_theme == 'folke/tokyonight.nvim' then
        vim.cmd('colorscheme tokyonight')
      end
    end,
  },
  {
'rose-pine/neovim',
    name = 'rose-pine',
    event = 'UIEnter',
    config = function()
      require('rose-pine').setup({
  disable_background = true,
  disable_float_background = true,
      })
      if random_theme == 'rose-pine/neovim' then
        vim.cmd('colorscheme rose-pine')
      end
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'UIEnter',
    config = function()
      require('catppuccin').setup({
transparent_background = true,
      })
      if random_theme == 'catppuccin/nvim' then
        vim.cmd('colorscheme catppuccin')
      end
    end,
  }
}
