return {
  {
    'pwntester/octo.nvim',
    dev = true,
    ---@module 'octo'
    ---@type OctoConfig
    opts = {
      default_merge_method = 'squash',
      enable_builtin = true,
      default_to_projects_v2 = true,
    },
    cmd = 'Octo',
  },
}
