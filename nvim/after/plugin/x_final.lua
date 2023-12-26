vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
    local intro = require('custom.intro')
    intro.show()
    end
    })

print 'Ready to go!'
