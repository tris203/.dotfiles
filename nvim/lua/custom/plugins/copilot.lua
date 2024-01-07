--vim.g.copilot_assume_mapped = true;

return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
  },
}
