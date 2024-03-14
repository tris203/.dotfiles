-- Custom Keybinds NeoTree
-- test save - yes that worked - really?
--
-- <leader>e :NeoTree

local opts = { noremap = true, silent = true }

--  move blocks of text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- reset cursor position after half page jump
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', opts)
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', opts)

-- reset custer after J to append line
vim.keymap.set('n', 'J', 'mzJ`z')

--find and replace word under cursor
vim.keymap.set('n', '<leader>fr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- reset cursoe position after search
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- vim.api.nvim_set_keymap ctrl c to escape
vim.api.nvim_set_keymap('i', '<C-c>', '<ESC>', opts)

-- null Q press ( not sure why )
vim.api.nvim_set_keymap('n', 'Q', '<Nop>', opts)

-- harpoon keybindsi
--[[
vim.api.nvim_set_keymap('n', '<leader>a',
':lua require("harpoon.mark").add_file()<CR>', { desc = 'Harpoon [A]dd File'});
vim.api.nvim_set_keymap('n',
'<C-e>', ':lua require("harpoon.ui").togle_quick_menu()<CR>', { desc = 'Harpoon [E]xplore' });
vim.api.nvim_set_keymap('n', '<C-t>', ':lua require("harpoon.ui").nav_file(1)<CR>', { desc = 'Harpoon Toggle 1' });
vim.api.nvim_set_keymap('n', '<C-h>', ':lua require("harpoon.ui").nav_file(2)<CR>', { desc = 'Harpoon Toggle 2' });
vim.api.nvim_set_keymap('n', '<C-n>', ':lua require("harpoon.ui").nav_file(3)<CR>', { desc = 'Harpoon Toggle 3' });
vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("harpoon.ui").nav_file(4)<CR>', { desc = 'Harpoon Toggle 4' });
]]
--
-- disable the arrow keys, because i cant help myself
vim.api.nvim_set_keymap('n', '<up>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<down>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<left>', '<Nop>', opts)
vim.api.nvim_set_keymap('n', '<right>', '<Nop>', opts)

vim.api.nvim_set_keymap('n', '<leader>?', '<cmd>Cheatsheet<CR>', { noremap = true, silent = true, desc = 'Cheatsheet' })

vim.keymap.set('n', '<leader><leader>', function()
  vim.cmd 'so'
end)

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

vim.api.nvim_set_keymap('n', '<LEADER>lo', "<cmd>echo 123<CR>", {} )


