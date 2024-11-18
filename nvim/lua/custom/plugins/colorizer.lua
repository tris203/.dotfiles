return {
  ----'mehalter/nvim-colorizer.lua',
  --'NvChad/nvim-colorizer.lua',
  --event = 'VeryLazy',
  --enabled = false,
  --opts = {
  --  user_default_options = {
  --    tailwind = true,
  --    mode = 'background',
  --    always_update = true,
  --  },
  --},
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
    'rachartier/tiny-devicons-auto-colors.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    event = 'VeryLazy',
    opts = {},
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
