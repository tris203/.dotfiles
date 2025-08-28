-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':~')
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  'stevearc/oil.nvim',
  cmd = { 'Oil', 'OilOpen' },
  config = function()
    local detail = false
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
      win_options = {
        winbar = '%!v:lua.get_oil_winbar()',
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
  dependencies = {
    'nvim-mini/mini.icons',
  },
}
