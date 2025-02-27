local M = {}

function M.get_basepath(lsp_name)
  local is_nixos = require('helpers.nix').is_nixos

  if is_nixos then
    vim.print 'not implemented yet'
    --TODO: What do we do here, return eval?
  else
    return require('mason-registry').get_package('rzls'):get_install_path()
  end
end

return M
