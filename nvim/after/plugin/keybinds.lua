-- Custom Keybinds NeoTree 
-- test save - yes that worked - really?
--
-- <leader>e :NeoTree

 local opts = { noremap = true, silent = true }

-- open NeoTree
vim.api.nvim_set_keymap('n', '<leader>ef', ':NvimTreeToggle<CR>', { noremap = true, silent=true, desc = '[E]xplorer [F]iles' });

-- open Undotree 
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, desc = '[U]ndo Tree' });

-- open fugitive 
vim.api.nvim_set_keymap('n', '<leader>go', ':Git<CR>', { noremap= true,  desc = '[G]it [O]pen Status' });

--  move blocks of text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- reset cursor position after half page jump
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', opts);
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', opts);

-- reset custer after J to append line 
vim.keymap.set("n", "J", "mzJ`z")


--find and replace word under cursor
vim.keymap.set("n", "<leader>fr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- reset cursoe position after search
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts);
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts);

-- vim.api.nvim_set_keymap ctrl c to escape 
vim.api.nvim_set_keymap('i', '<C-c>', '<ESC>', opts);

-- null Q press ( not sure why )
vim.api.nvim_set_keymap('n', 'Q', '<Nop>', opts);

-- Ctrl S to save
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', opts);
-- Ctrl S to save in insert mode
vim.api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<CR>', opts);


-- harpoon keybindsi
--[[
vim.api.nvim_set_keymap('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { desc = 'Harpoon [A]dd File'});  
vim.api.nvim_set_keymap('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'Harpoon [E]xplore' });
vim.api.nvim_set_keymap('n', '<C-t>', ':lua require("harpoon.ui").nav_file(1)<CR>', { desc = 'Harpoon Toggle 1' });
vim.api.nvim_set_keymap('n', '<C-h>', ':lua require("harpoon.ui").nav_file(2)<CR>', { desc = 'Harpoon Toggle 2' });
vim.api.nvim_set_keymap('n', '<C-n>', ':lua require("harpoon.ui").nav_file(3)<CR>', { desc = 'Harpoon Toggle 3' });
vim.api.nvim_set_keymap('n', '<C-b>', ':lua require("harpoon.ui").nav_file(4)<CR>', { desc = 'Harpoon Toggle 4' });
]]-- 

-- harpoon2 keybinds 
local harpoon = require("harpoon")
harpoon:setup({})
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-t>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-h>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-b>", function() harpoon:list():select(4) end)

-- disable the arrow keys, because i cant help myself
vim.api.nvim_set_keymap('n', '<up>', '<Nop>', opts);
vim.api.nvim_set_keymap('n', '<down>', '<Nop>', opts);
vim.api.nvim_set_keymap('n', '<left>', '<Nop>', opts);
vim.api.nvim_set_keymap('n', '<right>', '<Nop>', opts);


vim.keymap.set('n', '<leader>sgf', require('telescope.builtin').git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[G]rep [S]earch Files' })
vim.keymap.set('n', '<leader>ggr', ':LiveGrepGitRoot<cr>', { desc = '[G]rep Search [G]it [R]oot' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
