-- [[ Configure nvim-cmp ]]cmp
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.shortmess:append 'c'

luasnip.config.setup {}

luasnip.config.setup {}

local lspkind = require 'lspkind'
lspkind.init()

local custom_names = {
  cmp_yanky = 'Yanky',
  nerdfont = 'NF Icon',
  emoji = 'Emoji',
  buffer = 'Buffer',
  supermaven = 'SuperMaven',
  git = 'Git',
  ['vim-dadbod-completion'] = 'DB',
}

local custom_icons = {
  Yanky = '',
  Copilot = '',
  ['NF Icon'] = '󰌓',
  Emoji = '',
  Buffer = '󰧮',
  DB = '',
  SuperMaven = '',
  Git = '󰊤',
}

cmp.setup {
  view = {
    entries = { name = 'custom', selection_order = 'near_cursor' },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- completion = { completeopt = 'menu,menuone,noinsert' },

  -- For an understanding of why these mappings were
  -- chosen, you will need to read `:help ins-completion`
  --
  -- No, but seriously. Please read `:help ins-completion`, it is really good!
  mapping = cmp.mapping.preset.insert {
    -- Select the [n]ext item
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<down>'] = cmp.mapping.select_next_item(),
    -- Select the [p]revious item
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<up>'] = cmp.mapping.select_prev_item(),

    -- Scroll the documentation window [b]ack / [f]orward
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),

    -- Accept ([y]es) the completion.
    --  This will auto-import if your LSP supports it.
    --  This will expand snippets if the LSP sent a snippet.
    ['<C-y>'] = cmp.mapping.confirm { select = true },

    -- Manually trigger a completion from nvim-cmp.
    --  Generally you don't need this, because nvim-cmp will display
    --  completions whenever it has completion options available.
    ['<C-Space>'] = cmp.mapping.complete {},

    -- Think of <c-l> as moving to the right of your snippet expansion.
    --  So if you have a snippet that's like:
    --  function $name($args)
    --    $body
    --  end
    --
    -- <c-l> will move you to the right of each of the expansion locations.
    -- <c-h> is similar, except moving you backwards.
    -- ['<right>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.get_selected_entry() then
        cmp.confirm { select = true }
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<right>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.confirm { select = true }
      end
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { 'i', 's' }),
    ['<left>'] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { 'i', 's' }),

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },
  -- cmp.setup {
  --   snippet = {
  --     expand = function(args)
  --       luasnip.lsp_expand(args.body)
  --     end,
  --   },
  --   mapping = cmp.mapping.preset.insert {
  --     ['<C-n>'] = cmp.mapping.select_next_item(),
  --     ['<C-p>'] = cmp.mapping.select_prev_item(),
  --     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
  --     ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --     ['<C-Space>'] = cmp.mapping.complete {},
  --     ['<CR>'] = cmp.mapping.confirm {
  --       behavior = cmp.ConfirmBehavior.Replace,
  --       select = true,
  --     },
  --     ['<C-Tab>'] = cmp.mapping(function(fallback)
  --       if cmp.visible() then
  --         cmp.select_next_item()
  --       elseif luasnip.expand_or_locally_jumpable() then
  --         luasnip.expand_or_jump()
  --       else
  --         fallback()
  --       end
  --     end, { 'i', 's' }),
  --   },
  sources = {
    { name = 'copilot' },
    { name = 'supermaven' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer', max_item_count = 5 },
    { name = 'vim-dadbod-completion', keyword_length = 2 },
    { name = 'cmp_yanky', max_item_count = 10 },
    { name = 'path', max_item_count = 5 },
    { name = 'git' },
    { name = 'emoji', max_item_count = 10 },
    { name = 'nerdfont', max_item_count = 10 },
  },
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = function(entry, item)
      local color_item = require('nvim-highlight-colors').format(entry, { kind = item.kind })
      item = require('lspkind').cmp_format {
        -- any lspkind format settings here
        mode = 'symbol_text',
        maxwidth = 50,
        symbol_map = custom_icons,
        -- can also be a function to dynamically calculate max width such as
        -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
        ellipsis_char = '...',
        show_labelDetails = true, -- show labelDetails in menu. Disabled by default

        -- The function below will be called before any actual modifications from lspkind
        -- so that you can provide more controls on popup customization.
        -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
        before = function(oentry, vim_item)
          if custom_names[oentry.source.name] then
            vim_item.kind = custom_names[oentry.source.name]
          end

          return vim_item
        end,
      }(entry, item)
      if color_item.abbr_hl_group then
        item.kind_hl_group = color_item.abbr_hl_group
        item.kind = color_item.abbr
      end
      return item
    end,
  },
}

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file('lua/custom/snippets/*.lua', true)) do
  loadfile(ft_path)()
end

-- vim: ts=2 sts=2 sw=2 et
