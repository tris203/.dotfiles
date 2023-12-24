return {
  'stevearc/oil.nvim',
  cmd = { 'Oil', 'OilOpen' },
  opts = {
    view_options = {
      show_hidden = true,
    },
  },
  keys = {
{ '-', '<cmd>Oil<CR>', { noremap = true, silent = true } },
  },
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
