-- Updated for nvim 0.12
return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
    },
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      -- Keymaps / autocmds wired up whenever any LSP attaches to a buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local hl_group = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic signs in the status column
      if vim.g.have_nerd_font then
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config { signs = { text = diagnostic_signs } }
      end

      -- Install LSP servers and formatters/linters via mason
      require('mason').setup()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylua',
          'lua-language-server',
          'markdownlint',
          'typescript-language-server',
          'pyright',
          'codelldb',
          'debugpy',
          'clangd',
          'json-lsp',
          'prettierd',
          'prettier',
          'isort',
          'black',
          'jdtls',
          'yaml-language-server',
          'postgres-language-server',
        },
      }

      -- Broadcast blink.cmp capabilities to every server
      vim.lsp.config('*', {
        capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('blink.cmp').get_lsp_capabilities()),
      })

      -- ── Server configurations ──────────────────────────────────────────────

      vim.lsp.config('clangd', {
        cmd = { 'clangd' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
        root_markers = { '.clangd', '.clang-format', 'compile_commands.json', 'compile_flags.txt', '.git' },
      })

      vim.lsp.config('pyright', {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'pyrightconfig.json', '.git' },
        settings = {
          python = {
            analysis = {
              typeCheckingMode = 'basic', -- off | basic | standard | strict
              autoImportCompletions = true, -- suggest auto-imports in completions
              useLibraryCodeForTypes = true, -- infer types from library source when stubs are missing
              autoSearchPaths = true, -- auto-add src/ etc. to search paths
              diagnosticMode = 'workspace', -- lint all files, not just open ones
              inlayHints = {
                variableTypes = true, -- show inferred types for variables
                functionReturnTypes = true, -- show inferred return types on functions
                parameterTypes = true, -- show types on function parameters (noisy)
                parameterNames = 'literals', -- show param names at call sites: off | literals | all
              },
            },
          },
        },
      })

      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'literals',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
              completeFunctionCalls = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'literals',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            updateImportsOnFileMove = { enabled = 'always' },
            suggest = {
              completeFunctionCalls = true,
            },
          },
        },
      })

      vim.lsp.config('lua_ls', {
        cmd = { 'lua-language-server' },
        filetypes = { 'lua' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = { globals = { 'vim' } },
            workspace = { library = vim.api.nvim_get_runtime_file('', true) },
          },
        },
      })

      vim.lsp.config('jdtls', {
        cmd = { 'jdtls' },
        filetypes = { 'java' },
        root_markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', 'settings.gradle', '.git' },
      })

      vim.lsp.config('yamlls', {
        cmd = { 'yaml-language-server', '--stdio' },
        filetypes = { 'yaml' },
        root_markers = { '.git' },
      })

      vim.lsp.config('jsonls', {
        cmd = { 'vscode-json-language-server', '--stdio' },
        filetypes = { 'json', 'jsonc' },
        root_markers = { '.git' },
      })

      -- NOTE: requires postgres-language-server.jsonc in the project root
      vim.lsp.config('postgres_lsp', {
        cmd = { 'postgres-language-server' },
        filetypes = { 'sql' },
        root_markers = { 'postgres-language-server.jsonc', '.git' },
      })

      vim.lsp.enable { 'clangd', 'pyright', 'ts_ls', 'lua_ls', 'postgres_lsp', 'jsonls', 'yamlls', 'jdtls' }
    end,
  },
}
