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
  -- volar = {
  --   init_options = {
  --     typescript = {
  --       tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
  --     },
  --   },
  -- },
}

local flake_eval =
  string.format([[(builtins.getFlake "%s").nixosConfigurations.%s.options]], require('helpers.nix').flake_loc, require('helpers.nix').get_hostname())
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

local additional_nix_servers = {
  -- ◍ bash-language-server bashls, bashls
  -- ◍ biome
  -- ◍ buf buf_ls, buf_ls
  -- ◍ clangd
  -- ◍ copilot-language-server
  -- ◍ docker-compose-language-service docker_compose_language_service, docker_compose_language_service
  -- ◍ dockerfile-language-server dockerls, dockerls
  -- ◍ html-lsp html, html
  -- ◍ intelephense
  -- ◍ json-lsp jsonls, jsonls
  -- ◍ lua-language-server lua_ls, lua_ls
  -- ◍ nil nil_ls, nil_ls
  -- ◍ roslyn
  -- ◍ rzls
  -- ◍ tailwindcss-language-server tailwindcss, tailwindcss
  -- ◍ templ
  -- ◍ vtsls
  -- ◍ vue-language-server volar, volar
  -- ◍ zls
}

return {
  servers = servers,
  non_mason_servers = non_mason_servers,
}
