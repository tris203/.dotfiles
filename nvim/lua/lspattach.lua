vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LspAttach', { clear = true }),
  callback = function(args)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = args.buf, desc = '[R]e[n]ame' })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = args.buf, desc = '[C]ode [A]ction' })

    vim.keymap.set('n', 'gd', function()
      Snacks.picker.lsp_definitions()
    end, { buffer = args.buf, desc = '[G]oto [D]efinition' })

    vim.keymap.set('n', 'gr', function()
      Snacks.picker.lsp_references()
    end, { buffer = args.buf, desc = '[G]oto [R]eferences' })
    vim.keymap.set('n', 'gI', function()
      Snacks.picker.lsp_implementations()
    end, { buffer = args.buf, desc = '[G]oto [I]mplementation' })
    vim.keymap.set('n', '<leader>D', function()
      Snacks.picker.lsp_type_definitions()
    end, { buffer = args.buf, desc = 'Type [D]efinition' })
    vim.keymap.set('n', '<leader>ds', function()
      Snacks.picker.lsp_symbols()
    end, { buffer = args.buf, desc = '[D]ocument [S]ymbols' })
    vim.keymap.set('n', '<leader>ws', function()
      Snacks.picker.lsp_workspace_symbols()
    end, { buffer = args.buf, desc = '[W]orkspace [S]ymbols' })
    vim.keymap.set('n', '<C-m-k>', vim.lsp.buf.signature_help, { buffer = args.buf, desc = 'Signature Documentation' })

    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = args.buf, desc = '[G]oto [D]eclaration' })
    vim.keymap.set('n', 'gD', vim.lsp.buf.type_definition, { buffer = args.buf, desc = '[G]oto [D]eclaration' })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = args.buf, desc = '[W]orkspace [A]dd Folder' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = args.buf, desc = '[W]orkspace [R]emove Folder' })
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = args.buf, desc = '[W]orkspace [L]ist Folders' })

    -- if client:supports_method 'textDocument/foldingRange' then
    --   vim.o.foldmethod = 'expr'
    --   vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
    --   -- vim.o.foldexpr = 'vim.lsp.foldexpr()'
    -- end
  end,
  desc = 'LspAttach autocommand',
})
