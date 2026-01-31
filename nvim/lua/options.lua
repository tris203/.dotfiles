-- [[ Setting oions ]]
-- See `:help vim.o`
-- NOTE: You can change these oions as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this oion if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.o.clipboard = 'unnamedplus'

vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
-- vim.o.foldtext =
--     [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) ]]

vim.o.foldtext = require 'foldtext'
vim.o.fillchars = 'fold: '
vim.o.foldnestmax = 3
vim.o.foldminlines = 1
vim.o.foldmethod = 'expr'
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldenable = true

-- Enable break indent
vim.o.breakindent = true

---global statusline
vim.o.laststatus = 3

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 750

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.spelllang = 'en_gb'
vim.o.spell = true

vim.o.diffopt = 'internal,filler,closeoff,linematch:30'

vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 150 }
  end,
})
-- vim: ts=2 sts=2 sw=2 et
