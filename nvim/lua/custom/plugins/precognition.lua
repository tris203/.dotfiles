return {
  {
    'tris203/precognition.nvim',
    event = 'VeryLazy',
    dev = true,
    --  enabled = false,
    --- @module "precognition"
    --- @type Precognition.PartialConfig
    opts = {
      startVisible = false,
      debounceMs = 400,
      -- highlightColor = { link = 'Function' },
      -- hints = { Zero = {  prio = 0 } },
      -- hints = { Zero = { text = 'â', prio = 10 } },
      disabled_fts = { 'netrw' },
    },
    -- config = function()
    --   require('precognition').setup()
    -- end,
    keys = {
      {
        '<leader>pr',
        function()
          require('precognition').toggle()
        end,
        desc = 'Toggle Precognition',
      },
    },
  },
  {
    'm4xshen/hardtime.nvim',
    enabled = false,
    opts = {
      -- callback = function(text)
      --   -- vim.print(vim.inspect(config))
      --   -- vim.print(text)
      --   require('precognition').peek()
      -- end,
    },
  },
}
