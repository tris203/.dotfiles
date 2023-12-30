vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimStarted',
  callback = function()
  local ok =  pcall(function()
    local intro = require('custom.intro')
    intro.show()
    end)
    if not ok then
      vim.print('Intro Skipped')
    end
    end
    })
