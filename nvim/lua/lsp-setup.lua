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

local servers = require('lsp-servers').servers
local non_mason_servers = require('lsp-servers').non_mason_servers

vim.lsp.config('*', {
  on_attach = require 'lspattach',
  capabilities = require 'lspcapabilities',
})

for server_name, config in pairs(servers) do
  vim.lsp.config(server_name, {
    settings = config,
  })
  vim.lsp.enable(server_name)
end

for server_name, config in pairs(non_mason_servers) do
  vim.lsp.config(server_name, {
    cmd = config.cmd,
    settings = config.settings,
  })
  vim.lsp.enable(server_name)
end

-- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'

-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }

-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = require 'lspcapabilities',
--       on_attach = require 'lspattach',
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end,
-- }

-- vim: ts=2 sts=2 sw=2 et
