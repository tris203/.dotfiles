return {
  {
    'copilotlsp-nvim/copilot-lsp',
    dev = true,
    init = function()
      vim.g.copilot_nes_debounce = 250
      vim.lsp.enable 'copilot_ls'
      vim.keymap.set('n', '<tab>', function()
        local bufnr = vim.api.nvim_get_current_buf()
        local state = vim.b[bufnr].nes_state
        if state then
          local _ = require('copilot-lsp.nes').walk_cursor_start_edit()
            or (require('copilot-lsp.nes').apply_pending_nes() and require('copilot-lsp.nes').walk_cursor_end_edit())
          return nil
        else
          return '<C-i>'
        end
      end, { desc = 'Accept Copilot NES suggestion', expr = true })
      vim.keymap.set('n', '<esc>', function()
        ---@diagnostic disable-next-line: empty-block
        if not require('copilot-lsp.nes').clear() then
          return '<esc>'
        end
        vim.keymap.set('n', '<leader>cr', function()
          require('copilot-lsp.nes').restore_suggestion()
          return nil
        end, { desc = 'Restore previous Copilot suggestion', expr = true })
      end)
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    build = 'make tiktoken',
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
      'CopilotChatCommit',
    },
    dependencies = {
      -- { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    ---@module 'CopilotChat'
    ---@type CopilotChat.config
    opts = {
      model = 'o3-mini',
      highlight_headers = false,
      -- separator = '---',
      error_header = '>[!ERROR] Error',

      -- debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
      },
      prompts = {
        NeovimCommit = {
          prompt = [[> #git:staged

You are an expert in generating accurate, professional commit messages for version control systems following the Conventional Commits specification.
Your task is to analyze the given git diff output and craft a commit message that adheres to these rules:

Structure of the commit message:

Subject:
Use the format type(scope): subject.
type: Select from one of these options: build, ci, docs, feat, fix, perf, refactor, revert, test, or vim-patch. it is imperative that you select the correct type.
scope: Optionally include a scope like (lsp), (treesitter), (float), etc., to describe the area affected.
Use the imperative voice. For example, write "Add feature" instead of "Added feature" or "Adds feature."
Keep the subject under 72 characters.
Body:
Clearly describe the Problem being solved.
Provide the Solution that resolves the problem.
Use concise, professional language.
Include "BREAKING CHANGE" if the commit introduces an API-breaking change.
Special notes:

If a breaking change exists, include "!" after the type in the subject (e.g., refactor(provider)!: ...) and a "BREAKING CHANGE" footer with details.
Ignore the subject requirements for fixup or squash commits.
Input format:

A git diff output, detailing code changes.
Output format:

A fully formatted commit message, including subject and body, following all specified rules.
The result MUST only contain the message
The result should be wrapped in a markdown block tagged with language `gitcommit`]],
        },
      },
    },
    keys = {
      { '<leader>cc', '<cmd>CopilotChatToggle<cr>', desc = 'Toggle Chat' },
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'Explain' },
      { '<leader>ccr', '<cmd>CopilotChatReview<cr>', desc = 'Review' },
      { '<leader>ccf', '<cmd>CopilotChatFix<cr>', desc = 'Fix' },
      { '<leader>cco', '<cmd>CopilotChatOptimize<cr>', desc = 'Optimize' },
      { '<leader>ccd', '<cmd>CopilotChatDocs<cr>', desc = 'Document' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>', desc = 'Test' },
      { '<leader>ccs', '<cmd>CopilotChatCommit<cr>', desc = 'Write Commit' },
    },

    -- See Commands section for default commands if you want to lazy load on them
  },
}
