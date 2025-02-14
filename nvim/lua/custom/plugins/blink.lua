return {
  {
    'saghen/blink.cmp',
    lazy = false, -- lazy loading handled internally
    -- dev = true,
    -- event = 'InsertEnter',
    -- optional: provides snippets for the snippet source
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- 'L3MON4D3/LuaSnip',
      -- 'saghen/blink.compat',
      {
        'Kaiser-Yang/blink-cmp-git',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
      -- 'giuxtaposition/blink-cmp-copilot',
      'fang2hou/blink-copilot',
      'ribru17/blink-cmp-spell',
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
          -- Git = '󰊤',
          Spell = '﬜',
        },
      },
      completion = {
        menu = {
          winblend = vim.o.pumblend,
          draw = {
            treesitter = { 'lsp', 'copilot' },
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
      snippets = {
        preset = 'default',
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
        default = { 'git', 'lsp', 'path', 'buffer', 'snippets', 'lazydev', 'copilot', 'dadbod', 'spell' },
        providers = {
          spell = {
            name = 'Spell',
            module = 'blink-cmp-spell',
            kind = 'Spell',
            opts = {
              -- EXAMPLE: Only enable source in `@spell` captures, and disable it
              -- in `@nospell` captures.
              enable_in_context = function()
                local captures = vim.treesitter.get_captures_at_cursor(0)
                local in_spell_capture = false
                for _, capture in ipairs(captures) do
                  if capture == 'spell' then
                    in_spell_capture = true
                  elseif capture == 'nospell' then
                    return false
                  end
                end
                return in_spell_capture
              end,
            },
          },
          copilot = {
            name = 'Copilot',
            -- module = 'blink-cmp-copilot',
            module = 'blink-copilot',
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
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
          git = {
            -- Because we use filetype to enable the source,
            -- we can make the score higher
            score_offset = 100,
            module = 'blink-cmp-git',
            name = 'Git',
            -- kind = 'Git',
            enabled = function()
              -- enable the source when the filetype is gitcommit or markdown
              return vim.tbl_contains({ 'gitcommit', 'markdown', 'octo' }, vim.o.filetype)
            end,
            --- @module 'blink-cmp-git'
            --- @type blink-cmp-git.Options
            -- stylua: ignore
            opts = {
              commit = {
                on_error = function() return true end,
              },
              git_centers = {
                github = {
                  issue = { on_error = function() return true end },
                  pull_request = { on_error = function() return true end },
                  mention = { on_error = function() return true end },
                },
              },
              -- some options for the blink-cmp-git
            },
          },
        },
      },
      fuzzy = {
        sorts = {
          function(a, b)
            local sort = require 'blink.cmp.fuzzy.sort'
            if a.source_id == 'spell' and b.source_id == 'spell' then
              return sort.label(a, b)
            end
          end,
          -- This is the normal default order, which we fall back to
          'score',
          'kind',
          'label',
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
  {
    'chrisgrieser/nvim-scissors',
    ---@module "scissors"
    ---@type Scissors.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      jsonFormatter = 'jq',
      editSnippetPopup = {
        keymaps = {
          deleteSnippet = '<C-X>',
        },
      },
      backdrop = {
        enabled = false,
      },
    },
    cmd = { 'ScissorsAddNewSnippet', 'ScissorsEditSnippet' },
  },
}
