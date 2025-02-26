-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  -- Git related plugins
  { 'tpope/vim-fugitive', cmd = { 'Git' }, keys = { { '<leader>go', '<cmd>Git<CR>', desc = '[G]it [O]pen' } } },
  -- { 'tpope/vim-rhubarb', cmd = { 'Gbrowse' } },
  { 'tpope/vim-unimpaired', event = 'VeryLazy' },
  { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {
    move_cursor = 'sticky',
  } },

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth', event = 'BufRead' },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      local is_nixos = require('helpers.nix').is_nixos
      if not is_nixos then
        require 'lsp-setup'
      else
        require('lsp-nix')
      end
    end,
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', enabled = not require('helpers.nix').is_nixos },
      { 'williamboman/mason-lspconfig.nvim', enabled = not require('helpers.nix').is_nixos },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      -- 'folke/neodev.nvim',
    },
  },
  -- Useful plugin to show you pending keybinds.
  -- {
  --   'folke/which-key.nvim',
  --   enabled = false,
  --   event = 'VeryLazy',
  --   opts = {},
  -- },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        -- vim.keymap.set('n', '<leader>gb', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle git blame' })
        -- vim.keymap.set('n', '<leader>gB', function()
        --   gs.blame_line { full = false }
        -- end, { buffer = bufnr, desc = 'Git Blame Line' })

        -- don't override the built-in and fugitive keymaps
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    event = 'UIEnter',
    -- See `:help lualine.txt`
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          -- theme = 'palenight',
          component_separators = '|',
          section_separators = '',
        },
        sections = {
          ---@diagnostic disable-next-line: undefined-field
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
  },

  -- {
  --   -- Add indentation guides even on blank lines
  --   'lukas-reineke/indent-blankline.nvim',
  --   event = 'VeryLazy',
  --   -- Enable `lukas-reineke/indent-blankline.nvim`
  --   -- See `:help ibl`
  --   main = 'ibl',
  --   opts = {},
  -- },
  -- "gc" to comment visual regions/lines
  -- { 'numToStr/Comment.nvim', opts = {}, event = 'LSPAttach' },
  { 'https://github.com/folke/ts-comments.nvim', event = 'VeryLazy', opts = {} },
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    -- dev = true,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    event = 'VeryLazy',
    config = function()
      require 'treesitter-setup'
    end,
    build = ':TSUpdate',
  },
  {
    'OXY2DEV/helpview.nvim',
    ft = 'help',
    opts = {
      preview = { icon_provider = 'mini' },
    },
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {
  dev = {
    path = '~/code',
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'man',
      },
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
