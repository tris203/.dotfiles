return {
  {
    -- 'folke/lazydev.nvim',
    'FelipeLema/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    ---@module "lazydev"
    ---@type lazydev.Config
    opts = {
      enabled = function()
        if vim.g.lazydev_enabled ~= nil then
          return false
        end

        local cwd = vim.uv.cwd()
        local is_dev = cwd and vim.uv.fs_stat(cwd .. '/runtime') and true or false
        return not is_dev
      end,
      library = {
        -- Library items can be absolute paths
        -- "~/projects/my-awesome-lib",
        -- Or relative, which means they will be resolved as a plugin
        -- "LazyVim",
        -- When relative, you can also provide a path to the library in the plugin dir
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim', words = { 'Snacks' } },
        { path = 'mini.test', words = { 'MiniTest' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
  -- {                                        -- optional completion source for require statements and module annotations
  --   'hrsh7th/nvim-cmp',
  --   opts = function(_, opts)
  --     opts.sources = opts.sources or {}
  --     table.insert(opts.sources, {
  --       name = 'lazydev',
  --       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
  --     })
  --   end,
  -- },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
