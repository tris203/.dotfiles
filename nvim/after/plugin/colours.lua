function ColourScheme(colour)
  colour = colour or 'tokyonight'

  -- custom gutters for tokyonight
  if colour == 'tokyonight' then
    local tokyotheme = require 'tokyonight'
    tokyotheme.setup {
      on_colors = function(colors)
        colors.fg_gutter = '#b2b8cf'
      end,
    }
  end

  vim.cmd('colorscheme ' .. colour)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
end

ColourScheme()
