return {
  {
    'tris203/precognition.nvim',
    lazy = true,
    dev = true,
    --  enabled = false,
    --- @module "precognition"
    --- @type Precognition.PartialConfig
    opts = {
      startVisible = false,
      debounceMs = 0.8 * 1000,
      -- highlightColor = { link = 'Function' },
      -- hints = { Zero = {  prio = 0 } },
      -- hints = {
      --   w = { prio = 0 },
      --   b = { prio = 0 },
      --   W = { prio = 0 },
      --   B = { prio = 0 },
      --   e = { prio = 0 },
      --   E = { prio = 0 },
      --   Dollar = { prio = 0 },
      --   Caret = { prio = 0 },
      --   Zero = { prio = 0 },
      -- },
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
    event = 'VeryLazy',
    -- enabled = false,
    opts = {
      disable_mouse = false,
      hints = {
        ['[dcyvV][ia][%(%)]'] = {
          message = function(keys)
            return 'Use ' .. keys:sub(1, 2) .. 'b instead of ' .. keys
          end,
          length = 3,
        },
        ['[dcyvV][ia][%{%}]'] = {
          message = function(keys)
            return 'Use ' .. keys:sub(1, 2) .. 'B instead of ' .. keys
          end,
          length = 3,
        },
      },
      restriction_mode = 'hint',
      disabled_keys = {
        ['<Up>'] = {},
        ['<Down>'] = {},
        ['<Left>'] = {},
        ['<Right>'] = {},
      },
      -- callback = function(text)
      --   -- vim.print(vim.inspect(config))
      --   -- vim.print(text)
      --   -- require('precognition').peek()
      -- end,
    },
  },
}
