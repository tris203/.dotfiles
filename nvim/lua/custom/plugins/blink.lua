local Icons = {
  Yanky = '',
  Copilot = '',
  ['NF Icon'] = '󰌓',
  Emoji = '',
  Buffer = '󰧮',
  Dadbod = '',
  supermaven = '',
  Git = '󰊤',
}

local IconKeys = vim.tbl_keys(Icons)

return {
  {
    'saghen/blink.cmp',
    -- lazy = false, -- lazy loading handled internally
    event = "InsertEnter",
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip', 'saghen/blink.compat', { 'tris203/blink-cmp-copilot', dev = true } },

    -- use a release tag to download pre-built binaries
    -- version = 'v0.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',
    config = function(_, opts)
      require('blink.cmp').setup(opts)
      for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
        loadfile(ft_path)()
      end
    end,
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
      },
      completion = {
        menu = {
          winblend = vim.o.pumblend,
          draw = {
            treesitter = true,
            -- columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            components = {
              kind_icon = {
                text = function(ctx)
                  if vim.tbl_contains(IconKeys, ctx.source_name) then
                    return Icons[ctx.source_name] .. ctx.icon_gap
                  end
                  return ctx.kind_icon .. ctx.icon_gap
                end,
              },
            },
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
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
      sources = {
        completion = {
          enabled_providers = { 'lsp', 'path', 'snippets', 'luasnip', 'buffer', 'lazydev', 'copilot', 'supermaven', 'dadbod' },
        },
        providers = {
          copilot = {
            name = 'Copilot',
            module = 'blink-cmp-copilot',
          },
          dadbod = {
            name = 'Dadbod',
            module = 'vim_dadbod_completion.blink',
          },
          supermaven = {
            name = 'supermaven',
            module = 'blink.compat.source',
          },
          -- dont show LuaLS require statements when lazydev has items
          lsp = { fallback_for = { 'lazydev' } },
          lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
        },
      },

      -- experimental auto-brackets support
      -- completion = { accept = { auto_brackets = { enabled = true } } }

      -- experimental signature help support
      -- signature = { enabled = true }
    },
    -- allows extending the enabled_providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { 'sources.completion.enabled_providers' },
  },
}
