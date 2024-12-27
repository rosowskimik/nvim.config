return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "Additional configuration on LSP attachment",
        group = vim.api.nvim_create_augroup("nvimlsp-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local telescope = require("telescope.builtin")
          map("gd", telescope.lsp_definitions, "[G]oto [D]efinitin")
          map("gr", telescope.lsp_references, "[G]oto [R]eferences")
          map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
          map("gt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")

          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          map("<F2>", vim.lsp.buf.rename, "Rename Symbol")
          map("<leader>i", vim.lsp.buf.code_action, "Code Action")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client then
            if client.server_capabilities.documentHighlightProvider then
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
              })
            end

            -- If server supports it, enable native inlay hints
            if client.server_capabilities.inlayHintProvider then
              vim.lsp.inlay_hint.enable(true, { event.buf })
              map("<leader>ti", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { event.buf })
              end, "[T]oggle [I]nlay hints")
            end
          end
        end,
      })
    end,
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "standard",
              },
            },
          },
        },
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--fallback-style=none",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--enable-config",
            "--offset-encoding=utf-16",
          },
          settings = {
            InlayHints = {
              Designators = true,
              Enabled = true,
              ParameterNames = true,
              DeducedTypes = true,
            },
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
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
              runtime = { version = "LuaJIT" },
              hint = { enable = true },
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  unpack(vim.api.nvim_get_runtime_file("", true)),
                },
                completion = {
                  callSnippet = "Replace",
                },
                diagnostics = {
                  disable = { "missing-fields" },
                },
              },
            },
          },
        },
        protols = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              experimental = { procAttrMacros = true },
              imports = {
                prefix = "crate",
              },
              cargo = {
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
                features = "all",
              },
              procMacro = {
                enable = true,
                attributes = { enable = true },
              },
              checkOnSave = {
                command = "clippy",
                features = "all",
                extraArgs = { "--no-deps" },
              },
              diagnostics = {
                disabled = { "unresolved-proc-macro" },
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
                  enable = "never",
                },
                lifetimeElisionHints = {
                  enable = "never",
                  useParameterNames = false,
                },
                maxLength = 25,
                parameterHints = {
                  enable = true,
                },
                reborrowHints = {
                  enable = "never",
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
      },
    },
  },
}
