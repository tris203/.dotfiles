return {
  'stevearc/oil.nvim',
  cmd = { 'Oil', 'OilOpen' },
  config = function()
    local detail = false
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['gd'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    }
  end,
  keys = {
    { '-', '<cmd>Oil<CR>', { noremap = true, silent = true } },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
