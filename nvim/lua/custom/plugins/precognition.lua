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
    dev = true,
    enabled = false,
    opts = {
      callback = function(config, text)
        vim.print(vim.inspect(config))
        vim.print(text)
      end,
    },
  },
}
