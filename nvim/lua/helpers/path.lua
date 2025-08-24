local M = {}

---translates a lsp name into a mason store path or a nix store path
---@param lsp_name string
---@return string
function M.get_path(lsp_name, suffix)
  local is_nixos = require('helpers.nix').is_nixos

  if is_nixos then
    local hostname = require('helpers.nix').get_hostname()
    local result = vim
      .system({ 'nix', 'eval', '--raw', string.format('%s.#nixosConfigurations.%s.pkgs.%s.outPath', require('helpers.nix').flake_loc, hostname, lsp_name) })
      :wait()
    assert(result.code == 0, 'Failed to get base path code:' .. vim.inspect(result))
    local basepath = result.stdout

    return vim.fs.joinpath(basepath, suffix)
  end

  --- Mason install:
  return vim.fn.expand '$MASON/packages/' .. lsp_name .. '/libexec'
end

return M
