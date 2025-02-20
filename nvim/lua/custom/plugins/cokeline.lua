local cache = {}
local harpoon_keys = { 'j', 'k', 'l', ';' }
local function harpoon_sorter()
  local setup = false

  local function marknum(buf, force)
    local harpoon = require 'harpoon'
    local b = cache[buf.number]
    if b == nil or force then
      local path = require('plenary.path'):new(buf.path):make_relative(vim.uv.cwd())
      for i, mark in ipairs(harpoon:list():display()) do
        if mark == path then
          b = i
          cache[buf.number] = b
          break
        end
      end
    end
    return b
  end

  -- Use this in `config.buffers.new_buffers_position`
  return function(a, b)
    -- Only run this if harpoon is loaded, otherwise just use the default sorting.
    -- This could be used to only run if a user has harpoon installed, but
    -- I'm mainly using it to avoid loading harpoon on UiEnter.
    local has_harpoon = package.loaded['harpoon'] ~= nil
    if not has_harpoon then
      ---@diagnostic disable-next-line: undefined-field
      return a._valid_index < b._valid_index
    elseif not setup then
      local refresh = function()
        cache = {}
      end
      require('harpoon'):extend {
        ADD = refresh,
        REMOVE = refresh,
        REORDER = refresh,
        LIST_CHANGE = refresh,
      }
      setup = true
    end
    -- switch the a and b._valid_index to place non-harpoon buffers on the left
    -- side of the tabline - this puts them on the right.
    local ma = marknum(a)
    local mb = marknum(b)
    if ma and not mb then
      return true
    elseif mb and not ma then
      return false
    elseif ma == nil and mb == nil then
      ma = a._valid_index
      mb = b._valid_index
    end
    return ma < mb
  end
end

return {
  'willothy/nvim-cokeline',
  -- enabled = false,
  event = 'UIEnter',
  -- lazy = false,
  priority = 900,
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for v0.4.0+
    'echasnovski/mini.icons',
    -- 'stevearc/resession.nvim',     -- Optional, for persistent history
  },
  config = function()
    local is_picking_focus = require('cokeline.mappings').is_picking_focus
    local is_picking_close = require('cokeline.mappings').is_picking_close

    -- vim.api.nvim_create_autocmd('ColorScheme', {
    --   callback = function()
    --     require('cokeline.hlgroups')._cache_clear()
    --   end,
    -- })

    require('cokeline').setup {
      -- show_if_buffers_are_at_least = 2,
      default_hl = {
        fg = function(buffer)
          return buffer.is_focused and 'Normal' or 'Comment'
        end,
        bg = function()
          return 'ColorColumn'
        end,
        bold = function(buffer)
          return buffer.is_focused
        end,
      },
      buffers = {
        new_buffers_position = harpoon_sorter(),
      },

      components = {
        -- {
        --   text = '',
        --   fg = get_hex('ColorColumn', 'bg'),
        --   bg = get_hex('Normal', 'bg'),
        -- },
        {
          text = function(buffer)
            return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. ' ' or buffer.devicon.icon
          end,
          fg = function(buffer)
            return (is_picking_focus() and 'DiagnosticWarn') or (is_picking_close() and 'DiagnosticError') or buffer.devicon.color
          end,
          italic = function()
            return (is_picking_focus() or is_picking_close())
          end,
          bold = function()
            return (is_picking_focus() or is_picking_close())
          end,
        },
        {
          text = function(buffer)
            local harpoon_key = harpoon_keys[cache[buffer.number]]
            return harpoon_key and '󱡁' .. harpoon_key or ''
          end,
          italic = true,
          fg = 'Comment',
        },
        {
          text = ' ',
        },
        {
          text = function(buffer)
            return buffer.unique_prefix
          end,
          fg = function()
            return 'ColorColumn'
          end,
          italic = true,
        },
        {
          text = function(buffer)
            return buffer.filename .. '  '
          end,
          fg = function(buffer)
            return (buffer.diagnostics.errors > 0 and 'DiagnosticError') or (buffer.diagnostics.warnings > 0 and 'DiagnosticWarn') or nil
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
            return '󰅖'
          end,
          fg = function(buffer)
            if buffer.is_modified then
              return 'DiffAdd'
            end
            return nil
          end,
          on_click = function(_, _, _, _, buffer)
            buffer:delete()
          end,
        },
        {
          text = ' | ',
          bg = 'Normal',
          fg = 'DiagnosticInfo',
        },
        -- {
        --   text = '',
        --   fg = get_hex('ColorColumn', 'bg'),
        --   bg = get_hex('Normal', 'bg'),
        -- },
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
