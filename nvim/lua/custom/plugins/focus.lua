return {
  {
    'nvim-focus/focus.nvim',
    event = 'UIEnter',
    -- enabled = false,
    opts = {
      ui = {
        cursorline = false,
        signcolumn = false,
        winhighlight = false,
      },
    },
    config = function(_, opts)
      local ignore_filetypes = {
        ['oil'] = true,
        ['neo-tree'] = true,
        ['dap-repl'] = true,
        ['neotest-summary'] = true,
        SidebarNvim = true,
        trouble = true,
        terminal = true,
        dapui_console = true,
        dapui_watches = true,
        dapui_stacks = true,
        dapui_breakpoints = true,
        dapui_scopes = true,
        NeogitStatus = true,
        NeogitLogView = true,
        NeogitPopup = true,
        NeogitCommitMessage = true,
        OverseerList = true,
        fish = true,
        Avante = true,
        AvanteInput = true,
        AvanteSelectedFiles = true,
      }

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local buf = args.buf
          if ignore_filetypes[vim.bo[buf].filetype] then
            vim.b[buf].focus_disable = true
          else
            vim.b[buf].focus_disable = nil
          end
        end,
      })

      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.api.nvim_win_get_config(win).zindex == nil and ignore_filetypes[vim.bo[buf].filetype] then
          vim.b[buf].focus_disable = true
        end
      end

      require('focus').setup(opts)
    end,
  },
  {
    'nvim-zh/colorful-winsep.nvim',
    event = { 'WinNew' },
    opts = {},
  },
}
