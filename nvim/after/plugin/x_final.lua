vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    local intro = require('custom.intro')
    intro.show()
    vim.cmd('colorscheme tokyonight')
    end
    })

print 'Ready to go!'
