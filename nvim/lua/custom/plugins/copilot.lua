return {
  {
    'zbirenbaum/copilot.lua',
    event = 'VeryLazy',
    opts = {
      -- suggestion = {
      --   auto_trigger = true,
      -- },
      suggestion = {
        enabled = false,
      },
    },
    panel = {
      enabled = false,
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    -- dev = true,
    event = 'VeryLazy',
    opts = {},
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
      'CopilotChatStop',
      'CopilotChatReset',
      'CopilotChatSave',
      'CopilotChatLoad',
      'CopilotChatDebugInfo',
      'CopilotChatExplain',
      'CopilotChatReview',
      'CopilotChatFix',
      'CopilotChatOptimize',
      'CopilotChatDocs',
      'CopilotChatTests',
      'CopilotChatFixDiagnostic',
      'CopilotChatCommit',
      'CopilotChatCommitStaged',
    },
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
    },
    opts = {
      -- debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
      },
    },
    keys = {
      { '<leader>cc',  '<cmd>CopilotChatToggle<cr>',       desc = 'Toggle Chat' },
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>',      desc = 'Explain' },
      { '<leader>ccr', '<cmd>CopilotChatReview<cr>',       desc = 'Review' },
      { '<leader>ccf', '<cmd>CopilotChatFix<cr>',          desc = 'Fix' },
      { '<leader>cco', '<cmd>CopilotChatOptimize<cr>',     desc = 'Optimize' },
      { '<leader>ccd', '<cmd>CopilotChatDocs<cr>',         desc = 'Document' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>',        desc = 'Test' },
      { '<leader>ccs', '<cmd>CopilotChatCommitStaged<cr>', desc = 'Write Commit' },
    },

    -- See Commands section for default commands if you want to lazy load on them
  },
}
