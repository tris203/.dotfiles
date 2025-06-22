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
      -- 'saghen/blink.compat',
      {
        'Kaiser-Yang/blink-cmp-git',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
      -- 'giuxtaposition/blink-cmp-copilot',
      'fang2hou/blink-copilot',
    },
    -- use a release tag to download pre-built binaries
    version = '*',
    -- commit = 'b2d13ba',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = require('helpers.nix').is_nixos and 'nix run .#build-plugin' or 'cargo build --release',
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
      cmdline = {
        -- enabled = false,
        completion = {
          menu = {
            draw = {
              columns = { { 'kind_icon', gap = 1 }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
            },
          },
        },
      },
      sources = {
        per_filetype = {
          codecompanion = { 'codecompanion' },
        },
        default = { 'git', 'lsp', 'path', 'buffer', 'snippets', 'lazydev', 'copilot', 'dadbod' },
        providers = {
          copilot = {
            -- module = 'blink-cmp-copilot',
            module = 'blink-copilot',
            async = true,
          },
          snippets = {
            opts = {
              extended_filetypes = { octo = { 'markdown' } },
            },
          },
          dadbod = {
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
