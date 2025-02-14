return {
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telscope/telescope.nvim',
    },
    dev = true,
    ---@module 'octo'
    ---@type OctoConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      default_merge_method = 'squash',
      enable_builtin = true,
      default_to_projects_v2 = true,
    },
    config = function(_, opts)
      require('octo').setup(opts)
      vim.treesitter.language.register('markdown', { 'octo' })
    end,
    cmd = 'Octo',
  },
}
