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
    dependencies = { 'tpope/vim-fugitive' },
    init = function()
      vim.g.diffs = {
        integrations = {
          fugitive = true,
          neojj = true,
        },
        highlights = {
          intra = { enabled = false },
        },
      }
    end,
  },
}
