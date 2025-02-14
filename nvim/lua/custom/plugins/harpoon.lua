local function checkifDefaultBuffer()
  local prev_buf = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_line_count(prev_buf) == 1 and vim.api.nvim_buf_get_lines(prev_buf, 0, -1, false)[1] == '' then
    return prev_buf
  end
  return nil
end
return {
  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    event = 'VeryLazy',
    dev = false,
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = { save_on_toggle = true },
      }

      local harpoon_extensions = require 'harpoon.extensions'
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      {
        '<leader>a',
        function()
          local harpoon = require 'harpoon'
          harpoon:list():add()
        end,
        desc = 'Add to Harpoon List',
      },
      {
        '<leader>h',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Toggle Harpoon List',
      },
      {
        '<c-h>',
        function()
          local harpoon = require 'harpoon'
          local prev_buf = checkifDefaultBuffer()
          harpoon:list():select(1)
          if prev_buf then
            vim.api.nvim_buf_delete(prev_buf, {})
          end
        end,
        desc = 'Select Harpoon List 1',
      },
      {
        '<c-j>',
        function()
          local prev_buf = checkifDefaultBuffer()
          local harpoon = require 'harpoon'
          harpoon:list():select(2)
          if prev_buf then
            vim.api.nvim_buf_delete(prev_buf, {})
          end
        end,
        desc = 'Select Harpoon List 2',
      },
      {
        '<c-k>',
        function()
          local prev_buf = checkifDefaultBuffer()
          local harpoon = require 'harpoon'
          harpoon:list():select(3)
          if prev_buf then
            vim.api.nvim_buf_delete(prev_buf, {})
          end
        end,
        desc = 'Select Harpoon List 3',
      },
      {
        '<c-l>',
        function()
          local harpoon = require 'harpoon'
          local prev_buf = checkifDefaultBuffer()
          harpoon:list():select(4)
          if prev_buf then
            vim.api.nvim_buf_delete(prev_buf, {})
          end
        end,
        desc = 'Select Harpoon List 4',
      },
      {
        '<c-;>',
        function()
          local harpoon = require 'harpoon'
          local prev_buf = checkifDefaultBuffer()
          harpoon:list():select(5)
          if prev_buf then
            vim.api.nvim_buf_delete(prev_buf, {})
          end
        end,
        desc = 'Select Harpoon List 4',
      },
    },
  },
}
