return -- lazy.nvim
{
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = function()
 -- Toggle the profiler
      Snacks.toggle.profiler():map("<leader>pp")
      -- Toggle the profiler highlights
      Snacks.toggle.profiler_highlights():map("<leader>ph")
      return {
        notifier = {
          enabled = true,
          margin = { top = 1, right = 3 },
          padding = true,
        },
      }
    end,
    keys = {
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
        '<leader>ps',
        function()
          Snacks.profiler.scratch()
        end,
        desc = 'Profiler Scratch Bufer',
      },
    },
  },
  {
    'folke/noice.nvim',
    priority = 1000,
    lazy = false,
    -- enabled = false,
    ---@module "noice"
    ---@type NoiceConfig
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
