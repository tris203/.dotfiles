return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      -- suggestion = {
      --   auto_trigger = true,
      -- },
      suggestion = {
        enabled = false,
      },
    },
    panel = {
      enabled = false,
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    opts = {},
  },
}
