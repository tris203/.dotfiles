return -- lazy.nvim
{
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      indent = {
        enabled = true,
        chunk = {
          enabled = true,
        },
      },
      picker = {
        enabled = true,
        layout = {
          preset = function()
            return vim.o.columns >= 120 and 'telescope' or 'vertical'
          end,
        },
      },
      image = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        margin = { top = 1, right = 3 },
        padding = true,
        timeout = 3000,
      },
      statuscolumn = { enabled = true },
      -- scroll = { enabled = true },
      zen = { enabled = true },
      styles = {
        -- wo = { wrap = true },
        ---@diagnostic disable-next-line: missing-fields
        notification = {
          wo = {
            winblend = 0,
            -- wrap = true,
          },
        },
      },
    },
    keys = {
      {
        '<leader>ps',
        function()
          Snacks.profiler.scratch()
        end,
        desc = 'Profiler Scratch Bufer',
      },
      {
        '<leader>z',
        function()
          Snacks.zen()
        end,
        desc = 'Toggle Zen Mode',
      },
      {
        '<leader>Z',
        function()
          Snacks.zen.zoom()
        end,
        desc = 'Toggle Zoom',
      },
      {
        '<leader>.',
        function()
          Snacks.scratch()
        end,
        desc = 'Toggle Scratch Buffer',
      },
      {
        '<leader>S',
        function()
          Snacks.scratch.select()
        end,
        desc = 'Select Scratch Buffer',
      },
      {
        '<leader>n',
        function()
          Snacks.notifier.show_history()
        end,
        desc = 'Notification History',
      },
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>gB',
        function()
          Snacks.gitbrowse()
        end,
        desc = 'Git Browse',
      },
      {
        '<leader>gb',
        function()
          Snacks.git.blame_line()
        end,
        desc = 'Git Blame Line',
      },
      {
        '<leader>un',
        function()
          Snacks.notifier.hide()
        end,
        desc = 'Dismiss All Notifications',
      },
      {
        '<c-/>',
        function()
          Snacks.terminal()
        end,
        desc = 'Toggle Terminal',
      },
      {
        '<c-_>',
        function()
          Snacks.terminal()
        end,
        desc = 'which_key_ignore',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
      {
        '<leader>N',
        desc = 'Neovim News',
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = 'yes',
              statuscolumn = ' ',
              conceallevel = 3,
            },
          }
        end,
      },
      {
        '<leader>ro',
        function()
          Snacks.picker.recent()
        end,
      },
      {
        '<leader>sb',
        function()
          Snacks.picker.buffers()
        end,
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
      },
      {
        '<leader>sn',
        function()
          local config_path = vim.fn.stdpath 'config' --[[@as string]]
          Snacks.picker.files { cwd = config_path }
        end,
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
      },
      {
        'z=',
        function()
          Snacks.picker.spelling()
        end,
      },
      {
        '<leader>sc',
        function()
          Snacks.picker.colorschemes()
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          -- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          -- Snacks.toggle.line_number():map '<leader>ul'
          -- Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          -- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>lh'
          Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'

          Snacks.toggle.profiler():map '<leader>pp'
          Snacks.toggle.profiler_highlights():map '<leader>ph'
        end,
      })
    end,
  },
  {
    'folke/noice.nvim',
    priority = 1000,
    lazy = false,
    -- enabled = false,
    ---@module "noice"
    ---@type NoiceConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      views = {
        mini = {
          win_options = {
            winblend = 0, -- transparency
          },
        },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        hover = {
          -- enabled = false,
          silent = true,
        },
        signature = {
          enabled = false,
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      ---@type NoiceRouteConfig[]
      routes = {
        { filter = { event = 'msg_show', find = '%written$' }, view = 'mini' },
        { filter = { event = 'msg_show', find = 'Running healthchecks...' }, view = 'mini' },
        { filter = { event = 'notify', kind = 'warn', find = 'is deprecated' }, view = 'mini' },
        {
          filter = {
            event = 'notify',
            kind = 'warn',
            cond = function(message)
              local sources = { 'hardtime' }
              return vim.tbl_contains(sources, message.opts.title)
            end,
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'notify',
            kind = 'info',
            cond = function(message)
              local sources = { 'rzls.nvim', 'roslyn.nvim' }
              return vim.tbl_contains(sources, message.opts.title)
            end,
          },
          view = 'mini',
        },
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- 'rcarriga/nvim-notify',
    },
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
  },
}
