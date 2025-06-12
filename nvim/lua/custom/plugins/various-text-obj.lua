return {
  {
    'chrisgrieser/nvim-various-textobjs',
    vscode = true,
    event = 'VeryLazy',
    ---@module "various-textobjs"
    ---@type VariousTextobjs.Config
    opts = {
      keymaps = {
        useDefaults = true,
        disabledDefaults = { 'al', 'il' },
      },
    },
  },
}
