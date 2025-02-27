local M = {}

M.flake_loc = '/home/tris/code/.nix/'

M.is_nixos = (function()
  return vim.fn.executable 'nixos-rebuild' == 1 and true or false
end)()

---get safe nixos hostname
---@return string
function M.get_hostname()
  local non_nix_systems = { 'pop-os' }
  local hostname = vim.uv.os_gethostname()
  if vim.tbl_contains(non_nix_systems, hostname) then
    return 'x1'
  end
  return hostname
end

return M
