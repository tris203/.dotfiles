--  --  This function gets run when an LSP connects to a particular buffer.
--  local on_attach = function(_, bufnr)
--    -- NOTE: Remember that lua is a real programming language, and as such it is possible
--    -- to define small helper and utility functions so you don't have to repeat yourself
--    -- many times.
--
--    -- In this case, we create a function that lets us more easily define mappings specific
--    -- for LSP related items. It sets the mode, buffer and description for us each time.
--    local nmap = function(keys, func, desc)
--      if desc then
--        desc = 'LSP: ' .. desc
--      end
--
--      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--    end
--
--    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--    -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--    nmap('<leader>lf', vim.lsp.buf.format, '[L]SP [F]ormat')
--    nmap('<leader>lh', function()
--      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
--    end, 'Toggle inlay hints')
--
--    -- See `:help K` for why this keymap
--    -- nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--    nmap('<C-m-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--    -- Lesser used LSP functionality
--    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--    nmap('<leader>wl', function()
--      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--    end, '[W]orkspace [L]ist Folders')
--
--    -- Create a command `:Format` local to the LSP buffer
--    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--      vim.lsp.buf.format()
--    end, { desc = 'Format current buffer with LSP' })
--  end

require('which-key').add {
  {
    { '<leader>c', group = '[C]ode' },
    { '<leader>o', group = '[O]bsidian', icon = { icon = '󰇈', color = 'purple' } },
    { '<leader>cc', group = '[C]opilot [C]hat', icon = ';' },
    { '<leader>d', group = '[D]ocument' },
    { '<leader>r', group = '[R]ename' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>t', group = '[T]ests & Diagnostics' },
    { '<leader>g', group = '[G]it Search' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  },
}

-- -- document existing key chains
-- require('which-key').add {
--   ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
--   ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
--   ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
--   ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
--   ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
--   ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
--   ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
-- }

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup {
  registries = {
    'github:mason-org/mason-registry',
    -- 'github:syndim/mason-registry',
    'github:crashdummyy/mason-registry',
  },
}
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  html = {},
  -- gopls = {
  --   gopls = {
  --     hints = {
  --       assignVariableTypes = true,
  --       compositeLiteralFields = true,
  --       compositeLiteralType = true,
  --       constantValues = true,
  --       functionTypeParameters = true,
  --       parameterNames = true,
  --       rangeVariableTypes = true,
  --     },
  --   },
  -- },
  -- pyright = {},
  -- rust_analyzer = {
  --   ['rust-analyzer'] = {
  --   },
  -- },
  -- vtsls = {
  --   typescript = {
  --     suggest = { completeFunctionCalls = true },
  --     inlayHints = {
  --       parameterNames = { enabled = 'all' },
  --       parameterTypes = { enabled = true },
  --       variableTypes = { enabled = true },
  --       propertyDeclarationTypes = { enabled = true },
  --       functionLikeReturnTypes = { enabled = true },
  --       enumMemberValues = { enabled = true },
  --     },
  --   },
  --   javascript = {
  --     suggest = { completeFunctionCalls = true },
  --     inlayHints = {
  --       parameterNames = { enabled = 'all' },
  --       parameterTypes = { enabled = true },
  --       variableTypes = { enabled = true },
  --       propertyDeclarationTypes = { enabled = true },
  --       functionLikeReturnTypes = { enabled = true },
  --       enumMemberValues = { enabled = true },
  --     },
  --   },
  --   vtsls = {
  --     experimental = {
  --       maxInlayHintLength = 30,
  --       completion = {
  --         enableServerSideFuzzyMatch = true,
  --       },
  --     },
  --   },
  -- },
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  nil_ls = {
    ['nil'] = {
      testSetting = 42,
      formatting = { command = { 'nixpkgs-fmt' } },
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      hint = { enable = true },
      diagnostics = {
        unusedLocalExclude = {
          '_*',
        },
      },
    },
  },
  volar = {
    init_options = {
      typescript = {
        tsdk = vim.fn.getcwd() .. '/node_modules/typescript/lib',
      },
    },
  },
  -- denols = {
  --   settings = {
  --     deno = {
  --       enable = true,
  --       lint = true,
  --       unstable = true,
  --       suggest = {
  --         imports = {
  --           hosts = {
  --             ['https://deno.land'] = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}

-- Setup neovim lua configuration
-- require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    -- if server_name == 'templ' then
    --   require('lspconfig')[server_name].setup {
    --     capabilities = capabilities,
    --     cmd = { '/home/tris/code/templ/dist/templ_linux_amd64_v1/templ', 'lsp', '-http=localhost:7474', '-log=/home/tris/templ.log' },
    --     on_attach = require 'lspattach',
    --     settings = servers[server_name],
    --     filetypes = { 'templ', 'go' },
    --   }
    --   return
    -- end
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = require 'lspattach',
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

require('roslyn').setup {
  args = {
    '--logLevel=Information',
    '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
    '--razorSourceGenerator='
      .. vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'packages', 'roslyn', 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
    '--razorDesignTimePath=' .. vim.fs.joinpath(
      vim.fn.stdpath 'data' --[[@as string]],
      'mason',
      'packages',
      'rzls',
      'libexec',
      'Targets',
      'Microsoft.NET.Sdk.Razor.DesignTime.targets'
    ),
  },
  config = {
    on_attach = require 'lspattach',
    capabilities = capabilities,
    handlers = require 'rzls.roslyn_handlers',
  },
}

require('rzls').setup {
  on_attach = require 'lspattach',
  capabilities = capabilities,
}

-- local pmlsp = vim.lsp.start_client {
--   name = 'pm-lsp',
--   cmd = { '/home/tris/code/pmlsp/apps/lsp/tmp/main' },
--   on_attach = on_attach,
--   root_dir = vim.loop.cwd()
-- }
--
-- if pmlsp then
--   vim.api.nvim_create_autocmd('FileType', {
--     callback = function()
--       vim.lsp.buf_attach_client(0, pmlsp)
--     end,
--   })
-- end

-- vim: ts=2 sts=2 sw=2 et
