return {
  {
    'brenoprata10/nvim-highlight-colors',
    -- enabled = false,
    event = 'VeryLazy',
    opts = {
      render = 'virtual',
      virtual_symbol = '',
      virtual_symbol_position = 'eow',
      virtual_symbol_prefix = ' ',
      virtual_symbol_suffix = '',
      enable_tailwind = true,
    },
  },
  {
    {
      'razak17/tailwind-fold.nvim',
      opts = {
        min_chars = 20,
      },
      dependencies = { 'nvim-treesitter/nvim-treesitter' },
      ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'blade', 'razor' },
    },
  },
}

-- #000000 #ffffff
-- #ffffff
-- #5de4c7
-- #bg-red-500
-- bg-green-500
-- bg-yellow-500
-- bg-purple-500
-- #5de2cc
