return {
  {
    'pwntester/octo.nvim',
    cmd = 'Octo',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    ---@module 'octo'
    ---@type OctoConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- use_local_fs = true,
      default_merge_method = 'squash',
      enable_builtin = true,
      default_to_projects_v2 = true,
      picker = 'snacks',
    },
    config = function(_, opts)
      require('octo').setup(opts)
      vim.treesitter.language.register('markdown', { 'octo' })
    end,
  },
}
