local M = {}

M.is_nixos = (function()
 return vim.fn.executable('nixos-rebuild')
end)()


return M
