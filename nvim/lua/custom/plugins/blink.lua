return {
  {
    'saghen/blink.cmp',
    -- lazy = false, -- lazy loading handled internally
    -- dev = true,
    event = 'InsertEnter',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- 'L3MON4D3/LuaSnip',
      'saghen/blink.compat',
      { 'petertriho/cmp-git', opts = {} },
      'giuxtaposition/blink-cmp-copilot',
      {
        'chrisgrieser/nvim-scissors',
        ---@module "scissors"
        ---@type Scissors.Config
        opts = {
          jsonFormatter = 'jq',
          editSnippetPopup = {
            keymaps = {
              deleteSnippet = '<C-X>',
            },
          },
        },
      },
    },
    -- use a release tag to download pre-built binaries
    version = '*',
    -- commit = 'b2d13ba',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- see the "default configuration" section below for full documentation on how to define
      -- your own keymap.
      keymap = { preset = 'super-tab' },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        kind_icons = {
          Copilot = '',
          Supermaven = '',
          Git = '󰊤',
        },
      },
      completion = {
        menu = {
          winblend = vim.o.pumblend,
          draw = {
            treesitter = { 'lsp', 'copilot', 'supermaven' },
            columns = { { 'kind_icon', gap = 1 }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
        },
      },
      -- snippets = {
      --   expand = function(snippet)
      --     require('luasnip').lsp_expand(snippet)
      --   end,
      --   active = function(filter)
      --     if filter and filter.direction then
      --       return require('luasnip').jumpable(filter.direction)
      --     end
      --     return require('luasnip').in_snippet()
      --   end,
      --   jump = function(direction)
      --     require('luasnip').jump(direction)
      --   end,
      -- },
      sources = {
        -- cmdline = {},
        default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev', 'copilot', 'supermaven', 'dadbod', 'git_cmp' },
        providers = {
          copilot = {
            name = 'Copilot',
            module = 'blink-cmp-copilot',
            kind = 'Copilot',
            async = true,
          },
          snippets = {
            opts = {
              extended_filetypes = { octo = { 'markdown' } },
            },
          },
          dadbod = {
            name = 'Dadbod',
            -- kind = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
          },
          supermaven = {
            name = 'supermaven',
            module = 'blink.compat.source',
            kind = 'Supermaven',
            async = true,
          },
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          git_cmp = {
            name = 'git',
            module = 'lazydev.integrations.blink',
            kind = 'Git',
          },
        },
      },
      -- experimental auto-brackets support
      -- completion = { accept = { auto_brackets = { enabled = true } } }

      -- experimental signature help support
      signature = { enabled = true },
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.completion.enabled_providers' },
    config = function(_, opts)
      -- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
      --   loadfile(ft_path)()
      -- end

      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
      vim.opt.shortmess:append 'c'

      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require('blink.cmp').setup(opts)
    end,
  },
}
