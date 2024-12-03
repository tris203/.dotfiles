return {
  'willothy/nvim-cokeline',
  event = 'UIEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',       -- Required for v0.4.0+
    'nvim-tree/nvim-web-devicons', -- If you want devicons
    -- 'stevearc/resession.nvim',     -- Optional, for persistent history
  },
  config = function()
    local is_picking_focus = require('cokeline.mappings').is_picking_focus
    local is_picking_close = require('cokeline.mappings').is_picking_close
    local get_hex = require('cokeline.hlgroups').get_hl_attr

    local lspWarn = get_hex('DiagnosticWarn', 'fg')
    local lspError = get_hex('DiagnosticError', 'fg')

    require('cokeline').setup {
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and get_hex('Normal', 'fg') or get_hex('ColorColumn', 'fg')
        end,
        bg = function()
          return get_hex('ColorColumn', 'bg')
        end,
      },

      components = {
        {
          text = ' ',
          bg = get_hex('Normal', 'bg'),
        },
        {
          text = '',
          fg = get_hex('ColorColumn', 'bg'),
          bg = get_hex('Normal', 'bg'),
        },
        {
          text = function(buffer)
            return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. ' ' or buffer.devicon.icon
          end,
          fg = function(buffer)
            return (is_picking_focus() and lspWarn) or (is_picking_close() and lspError) or buffer.devicon.color
          end,
          italic = function()
            return (is_picking_focus() or is_picking_close())
          end,
          bold = function()
            return (is_picking_focus() or is_picking_close())
          end,
        },
        {
          text = ' ',
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = function()
            return get_hex('ColorColumn', 'fg')
          end,
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. '  '
          end,
          bold = function(buffer)
            return buffer.is_focused
          end,
          fg = function(buffer)
            return (buffer.diagnostics.errors > 0 and lspError) or (buffer.diagnostics.warnings > 0 and lspWarn) or nil
          end,
          on_click = function(_, _, _, _, buffer)
            -- TODO: write a function that if the buffer isnt in the same tab then switch to that tab
            -- also look into bufferpick as this doesnt trigger the click
            buffer:focus()
          end,
        },
        {
          ---@param buffer Buffer
          text = function(buffer)
            if buffer.is_modified then
              return ''
            end
            if buffer.is_hovered then
              return '󰅙'
            end
            return '󰅖'
          end,
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
        },
        {
          text = '',
          fg = get_hex('ColorColumn', 'bg'),
          bg = get_hex('Normal', 'bg'),
        },
      },
    }
  end,
  keys = {
    {
      '<leader>bp',
      function()
        require('cokeline.mappings').pick 'focus'
      end,
      desc = 'Buffer Pick',
    },
  },
}
