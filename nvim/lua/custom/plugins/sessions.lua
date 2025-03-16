return {
  {
    'j-hui/fidget.nvim',
    lazy = true,
    opts = {
      progress = {
        display = {
          done_style = '@keyword',
        },
      },
      notification = {
        window = {
          winblend = vim.o.pumblend,
        },
      },
    },
  },
  {
    'willothy/savior.nvim',
    event = { 'InsertEnter', 'TextChanged' },
    dependencies = { 'j-hui/fidget.nvim' },
    opts = {},
  },
}
