-- require('which-key').add {
--   {
--     { '<leader>c', group = '[C]ode' },
--     { '<leader>o', group = '[O]bsidian', icon = { icon = '󰇈', color = 'purple' } },
--     { '<leader>cc', group = '[C]opilot [C]hat', icon = ';' },
--     { '<leader>d', group = '[D]ocument' },
--     { '<leader>r', group = '[R]ename' },
--     { '<leader>s', group = '[S]earch' },
--     { '<leader>w', group = '[W]orkspace' },
--     { '<leader>t', group = '[T]ests & Diagnostics' },
--     { '<leader>g', group = '[G]it Search' },
--     { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
--   },
-- }

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    -- 'github:syndim/mason-registry',
    'github:crashdummyy/mason-registry',
  },
}
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  html = {},
  -- nil_ls = {
  --   ['nil'] = {
  --     testSetting = 42,
  --     formatting = { command = { 'nixpkgs-fmt' } },
  --   },
  -- },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
      diagnostics = {
        unusedLocalExclude = {
          '_*',
        },
      },
    },
  },
  volar = {
    init_options = {
      typescript = {
        tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
      },
    },
  },
}

local flake_eval = [[(builtins.getFlake "/home/tris/code/.nix/").nixosConfigurations.vm.options]]
local non_mason_servers = {
  nixd = {
    cmd = { 'nixd' },
    settings = {
      nixd = {
        nixpkgs = {
          expr = 'import <nixpkgs> { }',
        },
        formatting = { command = { 'nixpkgs-fmt' } },
        options = {
          nixos = {
            expr = flake_eval,
          },
          home_manager = {
            expr = flake_eval .. '.home-manager.users.type.getSubOptions []',
          },
        },
      },
    },
  },
}

for server_name, config in pairs(non_mason_servers) do
  require('lspconfig')[server_name].setup {
    cmd = config.cmd,
    capabilities = require 'lspcapabilities',
    settings = config.settings,
  }
end

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = require 'lspcapabilities',
      on_attach = require 'lspattach',
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
