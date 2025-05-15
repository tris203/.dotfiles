return {
  {
    -- 'jmederosalvarado/roslyn.nvim',
    'seblyng/roslyn.nvim',
    ft = { 'cs', 'razor' },
    dependencies = {
      {
        'tris203/rzls.nvim',
        dev = true,
        config = function()
          local is_nixos = require('helpers.nix').is_nixos
          require('rzls').setup {
            path = is_nixos and 'rzls' or nil,
            on_attach = require 'lspattach',
            capabilities = require 'lspcapabilities',
          }
        end,
      },
    },
    config = function()
      local rzls_path = require('helpers.path').get_basepath 'rzls'
      local is_nixos = require('helpers.nix').is_nixos
      require('roslyn').setup {
        ---@diagnostic disable-next-line: missing-fields
        config = {
          cmd = {
            is_nixos and 'Microsoft.CodeAnalysis.LanguageServer' or 'roslyn',
            '--stdio',
            '--logLevel=Information',
            '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
            '--razorSourceGenerator=' .. vim.fs.joinpath(rzls_path, 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
            '--razorDesignTimePath=' .. vim.fs.joinpath(rzls_path, 'Targets', 'Microsoft.NET.Sdk.Razor.DesignTime.targets'),
            '--extension',
            vim.fs.joinpath(rzls_path, 'RazorExtension', 'Microsoft.VisualStudioCode.RazorExtension.dll'),
            -- '--stdio',
          },
          on_attach = require 'lspattach',
          capabilities = require 'lspcapabilities',
          handlers = require 'rzls.roslyn_handlers',
          settings = {
            ['csharp|inlay_hints'] = {
              csharp_enable_inlay_hints_for_implicit_object_creation = true,
              csharp_enable_inlay_hints_for_implicit_variable_types = true,

              csharp_enable_inlay_hints_for_lambda_parameter_types = true,
              csharp_enable_inlay_hints_for_types = true,
              dotnet_enable_inlay_hints_for_indexer_parameters = true,
              dotnet_enable_inlay_hints_for_literal_parameters = true,
              dotnet_enable_inlay_hints_for_object_creation_parameters = true,
              dotnet_enable_inlay_hints_for_other_parameters = true,
              dotnet_enable_inlay_hints_for_parameters = true,
              dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
              dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
            },
            ['csharp|code_lens'] = {
              dotnet_enable_references_code_lens = true,
            },
          },
        },
      }
    end,
    init = function()
      vim.filetype.add {
        extension = {
          razor = 'razor',
          cshtml = 'razor',
        },
      }
    end,
  },
}
