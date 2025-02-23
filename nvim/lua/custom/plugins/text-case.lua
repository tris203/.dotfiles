return {
  {
    'johmsalas/text-case.nvim',
    lazy = true,
    opts = {
      default_keymappings_enabled = false,
    },
    keys = {
      {
        'ga.',
        function()
          ---@module 'textcase'
          local commands = require('textcase').api

          local friendly_commands = {}
          for k, _ in pairs(commands) do
            local name = require('textcase').api.to_phrase_case(k)
            friendly_commands[name] = k
          end

          vim.ui.select(vim.tbl_keys(friendly_commands), {
            prompt = 'Choose a method:',
            format_item = function(item)
              return item
            end,
          }, function(selected)
            if selected then
              local command = friendly_commands[selected]
              require('textcase').lsp_rename(command)
            else
              print 'No selection made.'
            end
          end)
        end,
        mode = { 'n', 'x' },
        desc = 'Text Case Select',
      },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      'Subs',
      'TextCaseOpenTelescope',
      'TextCaseOpenTelescopeQuickChange',
      'TextCaseOpenTelescopeLSPChange',
    },
  },
}
