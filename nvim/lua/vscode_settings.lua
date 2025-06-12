if not vim.g.vscode then
  return {}
end

local Config = require 'lazy.core.config'
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  ---@diagnostic disable-next-line: undefined-field
  return plugin.vscode
end
vim.g.snacks_animate = false

-- Add some vscode specific keymaps
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    -- VSCode-specific keymaps for search and navigation
    vim.keymap.set('n', '<leader>sf', '<cmd>Find<cr>')
    vim.keymap.set('n', '<leader>sg', function()
      require('vscode').action 'workbench.action.findInFiles'
    end)

    vim.keymap.set('n', '<leader>lf', function()
      require('vscode').action 'editor.action.formatDocument'
    end)

    vim.keymap.set('n', '<leader>go', function()
      require('vscode').action 'workbench.view.scm'
    end)

    vim.keymap.set('n', '<leader>bp', '<cmd>Tabfind<cr>')

    -- Keep undo/redo lists in sync with VsCode
    vim.keymap.set('n', 'u', function()
      require('vscode').call 'undo'
    end)

    vim.keymap.set('n', '<C-r>', function()
      require('vscode').call 'redo'
    end)
  end,
})

return {
  {
    'snacks.nvim',
    opts = {
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
    },
  },
}
