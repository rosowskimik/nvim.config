local servers = {
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          autoImportCompletions = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'standard',
        },
      },
    },
  },
  clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--fallback-style=none',
      '--header-insertion=iwyu',
      '--header-insertion-decorators',
      '--enable-config',
      '--offset-encoding=utf-16',
    },
    settings = {
      InlayHints = {
        Designators = true,
        Enabled = true,
        ParameterNames = true,
        DeducedTypes = true,
      },
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  },
  gopls = {
    settings = {
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        hint = { enable = true },
        workspace = {
          checkThirdParty = false,
          library = {
            '${3rd}/luv/library',
            unpack(vim.api.nvim_get_runtime_file('', true)),
          },
          completion = {
            callSnippet = 'Replace',
          },
          diagnostics = {
            disable = { 'missing-fields' },
          },
        },
      },
    },
  },
  protols = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        experimental = { procAttrMacros = true },
        imports = {
          prefix = 'crate',
        },
        cargo = {
          loadOutDirsFromCheck = true,
          buildScripts = {
            enable = true,
          },
          features = 'all',
        },
        procMacro = {
          enable = true,
          attributes = { enable = true },
        },
        checkOnSave = {
          command = 'clippy',
          features = 'all',
          extraArgs = { '--no-deps' },
        },
        diagnostics = {
          disabled = { 'unresolved-proc-macro' },
        },
        inlayHints = {
          bindingModeHints = {
            enable = false,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
            minLines = 25,
          },
          closureReturnTypeHints = {
            enable = 'never',
          },
          lifetimeElisionHints = {
            enable = 'never',
            useParameterNames = false,
          },
          maxLength = 25,
          parameterHints = {
            enable = true,
          },
          reborrowHints = {
            enable = 'never',
          },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideNamedConstructor = false,
          },
        },
      },
    },
  },
  taplo = {},
  zls = {
    settings = {
      zls = {
        enable_inlay_hints = true,
        inlay_hints_show_builtin = true,
        inlay_hints_exclude_single_argument = true,
        inlay_hints_hide_redundant_param_names = false,
        inlay_hints_hide_redundant_param_names_last_token = false,
      },
    },
  },
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'simrat39/rust-tools.nvim',
      'hrsh7th/cmp-nvim-lsp',
      {
        'j-hui/fidget.nvim',
        version = '*',
        event = 'LspAttach',
        config = true,
      },
      {
        'ray-x/lsp_signature.nvim',
        event = 'LspAttach',
        opts = {
          bind = true,
          handler_opts = { border = 'single' },
        },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('nvimlsp-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<F2>', vim.lsp.buf.rename, 'Rename symbol')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame symbol')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>i', vim.lsp.buf.code_action, 'Code Action')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- Show signature help
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { buffer = event.buf, desc = 'LSP: Show signature help' })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client then
            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            if client.server_capabilities.documentHighlightProvider then
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
              })
            end

            -- If server supports it, enable native inlay hints
            if client.server_capabilities.inlayHintProvider and vim.bo.filetype ~= 'rust' then
              vim.lsp.inlay_hint.enable(true, { event.buf })
              map('<leader>ti', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { event.buf })
              end, '[T]oggle [I]nlay hints')
            end
          end
        end,
      })
      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local lspconfig = require 'lspconfig'
      for server_name, server in pairs(servers) do
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        lspconfig[server_name].setup(server)
      end

      -- Rust specific plugin for inlay hints
      -- Kept in case the native inlay hints look bad (extra long)
      local rust_server_opts = {
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            experimental = { procAttrMacros = true },
            imports = {
              prefix = 'crate',
            },
            cargo = {
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
              features = 'all',
            },
            procMacro = {
              enable = true,
              attributes = { enable = true },
            },
            checkOnSave = {
              command = 'clippy',
              features = 'all',
              extraArgs = { '--no-deps' },
            },
            diagnostics = {
              disabled = { 'unresolved-proc-macro' },
            },
          },
        },
      }
      require('rust-tools').setup {
        tools = {
          runnables = { use_telescope = true },
          hover_with_actions = false,
          inlay_hints = { highlight = 'NonText' },
        },
        server = rust_server_opts,
      }
    end,
  },
}
