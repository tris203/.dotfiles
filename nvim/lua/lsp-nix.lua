local servers = require('lsp-servers').servers
local non_mason_servers = require('lsp-servers').non_mason_servers

for server_name, config in pairs(non_mason_servers) do
  require('lspconfig')[server_name].setup {
    cmd = config.cmd,
    settings = config.settings,
  }
end

for server_name, config in pairs(servers) do
  require('lspconfig')[server_name].setup {
    cmd = config.cmd,
    settings = config.settings,
  }
end

-- vim: ts=2 sts=2 sw=2 et
