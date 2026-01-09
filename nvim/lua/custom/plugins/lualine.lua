return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  event = 'UIEnter',
  -- See `:help lualine.txt`
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = false,
        -- theme = 'palenight',
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'fancybuffers',
            -- show_filename_only = true, -- Shows shortened relative path when set to false.
            -- hide_filename_extension = false, -- Hide filename extension when set to true.
            show_modified_status = true, -- Shows indicator when the buffer is modified.
            --
            -- mode = 0, -- 0: Shows buffer name
            -- -- 1: Shows buffer index
            -- -- 2: Shows buffer name + buffer index
            -- -- 3: Shows buffer number
            -- -- 4: Shows buffer name + buffer number
            --
            -- max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
            -- -- it can also be a function that returns
            -- -- the value of `max_length` dynamically.
            filetype_names = {
              snacks_picker_input = 'Snacks Picker',
              harpoon = 'Harpoon Marks',
            }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
            --
            -- -- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
            -- use_mode_colors = false,
            --
            -- max_length = vim.o.columns / 3 * 6,
            buffers_color = {
              -- Same values as the general color option can be used here.
              active = 'lualine_c_normal', -- Color for active buffer.
              inactive = 'lualine_c_inactive', -- Color for inactive buffer.
            },
            fmt = function(name, ctx)
              local bufnr = ctx.bufnr
              local diags = vim.diagnostic.count(bufnr)
              local icon, icon_color = require('mini.icons').get('file', ctx.file)
              -- Find all buffers with the same name
              local buffers = vim.tbl_filter(function(b)
                return vim.api.nvim_buf_is_loaded(b)
              end, vim.api.nvim_list_bufs())
              local same = {}
              for _, b in ipairs(buffers) do
                if vim.api.nvim_buf_get_name(b):match '[^/\\]+$' == name then
                  table.insert(same, b)
                end
              end
              -- If duplicates, prefix with parent directory
              local display_name = name
              if #same > 1 then
                local path = vim.api.nvim_buf_get_name(bufnr)
                local parent = path:match '([^/\\]+)/[^/\\]+$'
                if parent then
                  display_name = parent .. '/' .. name
                end
              end
              -- Add harpoon letter if buffer is harpoon marked
              local harpoon_name = ''
              local harpoon_keys = { 'h', 'j', 'k', 'l' }
              if package.loaded['harpoon'] then
                local path = require('plenary.path'):new(vim.api.nvim_buf_get_name(bufnr)):make_relative(vim.uv.cwd())
                for i, mark in ipairs(require('harpoon'):list():display()) do
                  if mark == path then
                    harpoon_name = '󱡁' .. harpoon_keys[i]
                    break
                  end
                end
              end
              if vim.tbl_isempty(diags) then
                return string.format(
                  '%s%s%s %s',
                  '%#' .. icon_color .. '#' .. icon .. ' ',
                  require('lualine.highlight').component_format_highlight(ctx.highlights[(ctx.current and 'active' or 'inactive')]),
                  harpoon_name,
                  display_name
                )
              end
              local severity = next(diags) and math.min(unpack(vim.tbl_keys(diags))) or nil
              local color = {
                [vim.diagnostic.severity.ERROR] = '%#DiagnosticError#',
                [vim.diagnostic.severity.WARN] = '%#DiagnosticWarn#',
                [vim.diagnostic.severity.INFO] = '',
                [vim.diagnostic.severity.HINT] = '',
              }
              return string.format(
                '%s%s%s %s%s%s',
                '%#' .. icon_color .. '#' .. icon .. ' ',
                require('lualine.highlight').component_format_highlight(ctx.highlights[(ctx.current and 'active' or 'inactive')]),
                harpoon_name,
                color[severity] or '',
                display_name,
                require('lualine.highlight').component_format_highlight(ctx.highlights[(ctx.current and 'active' or 'inactive')])
              )
            end,
            --
            symbols = {
              modified = ' ●', -- Text to show when the buffer is modified
              alternate_file = '', -- Text to show to identify the alternate file
              directory = '', -- Text to show when the buffer is a directory
            },
          },
        },
        lualine_x = { 'diff', 'diagnostics', 'fileformat', 'filetype' },
        lualine_y = {
          {
            function()
              ---@type string
              ---@diagnostic disable-next-line: undefined-field
              local status = require('noice').api.status.mode.get()
              if string.find(status, 'recording') then
                return status
              end
              return ''
            end,
          },
          {
            'progress',
          },
        },
      },
    }
  end,
}
