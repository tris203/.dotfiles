return {
  {
    'rgroli/other.nvim',
    cmd = { 'Other' },
    config = function()
      require('other-nvim').setup {
        mappings = {
          'golang',
        },
      }
    end,
    keys = {
      { '<leader>eo', '<cmd>Other<CR>' },
    },
  },
}
