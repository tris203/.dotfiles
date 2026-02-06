return {
  {
    'nvim-mini/mini.diff',
    event = 'VeryLazy',
    config = function()
      require('mini.diff').setup {
        view = {
          style = 'sign',
          signs = {
            add = '┃',
            change = '┃',
            delete = '_',
          },
        },
      }
    end,
  },
  {
    'barrettruth/diffs.nvim',
    event = 'VeryLazy',
    dependencies = { 'tpope/vim-fugitive' },
    init = function()
      vim.g.diffs = {
        highlights = {
          gutter = false,
        },
      }
    end,
  },
}
