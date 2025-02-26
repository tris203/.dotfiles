local M = {}

M.is_nixos = (function()
  return vim.fn.executable 'nixos-rebuild' == 1 and true or false
end)()

return M
