-- Custom Keybinds NeoTree 
-- test save - yes that worked - really?
--
-- <leader>e :NeoTree

local map = vim.api.nvim_set_keymap
 local opts = { noremap = true, silent = true }

-- open NeoTree
map('n', '<leader>ee', ':NvimTreeToggle<CR>', { noremap = true, silent=true, desc = '[E]xplorer [T]oggle' });
map('n', '<leader>ef', ':NvimTreeFocus<CR>', { noremap = true, silent=true, desc = '[E]xplorer [F]ocus' });

-- open Undotree 
map('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, desc = '[U]ndo Tree' });

-- open fugitive 
map('n', '<leader>go', ':Git<CR>', { noremap= true,  desc = '[G]it [O]pen Status' });

-- reset cursor position after half page jump
map('n', '<C-d>', '<C-d>zz', opts);
map('n', '<C-u>', '<C-u>zz', opts);

-- reset cursoe position after search
map('n', 'n', 'nzzzv', opts);
map('n', 'N', 'Nzzzv', opts);

-- map ctrl c to escape 
map('i', '<C-c>', '<ESC>', opts);

-- null Q press ( not sure why )
map('n', 'Q', '<Nop>', opts);

-- Ctrl S to save
map('n', '<C-s>', ':w<CR>', opts);
-- Ctrl S to save in insert mode
map('i', '<C-s>', '<ESC>:w<CR>', opts);


-- harpoon keybinds
map('n', '<leader>a', ':lua require("harpoon.mark").add_file()<CR>', { desc = 'Harpoon [A]dd File'});
map('n', '<C-e>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { desc = 'Harpoon [E]xplore' });
map('n', '<C-t>', ':lua require("harpoon.ui").nav_file(1)<CR>', { desc = 'Harpoon Toggle 1' });
map('n', '<C-h>', ':lua require("harpoon.ui").nav_file(2)<CR>', { desc = 'Harpoon Toggle 2' });
map('n', '<C-n>', ':lua require("harpoon.ui").nav_file(3)<CR>', { desc = 'Harpoon Toggle 3' });
map('n', '<C-b>', ':lua require("harpoon.ui").nav_file(4)<CR>', { desc = 'Harpoon Toggle 4' });

-- disable the arrow keys, because i cant help myself
map('n', '<up>', '<Nop>', opts);
map('n', '<down>', '<Nop>', opts);
map('n', '<left>', '<Nop>', opts);
map('n', '<right>', '<Nop>', opts);


vim.keymap.set('n', '<leader>sg', require('telescope.builtin').git_files, { desc = '[S]earch [G]it Files' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>gs', require('telescope.builtin').live_grep, { desc = '[G]rep [S]earch Files' })
vim.keymap.set('n', '<leader>gg', ':LiveGrepGitRoot<cr>', { desc = '[G]rep Search [G]it Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
