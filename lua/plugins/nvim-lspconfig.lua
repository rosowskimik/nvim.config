return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp", "folke/snacks.nvim" },
    config = function(_, opts)
      -- Diagnostic appearance
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "single" },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚",
            [vim.diagnostic.severity.WARN] = "󰀪",
            [vim.diagnostic.severity.INFO] = "󰋽",
            [vim.diagnostic.severity.HINT] = "󰌶",
          },
        },
      })

      -- Server setup
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        vim.lsp.config[server] = config
        vim.lsp.enable(server)
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keymaps and features on attach",
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(event)
          local buf = event.buf
          local function map(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, {
              buffer = buf,
              desc = "LSP: " .. desc,
            })
          end

          -- Navigation (snacks.picker)
          map("gd", function()
            Snacks.picker.lsp_definitions()
          end, "Goto definition")
          map("gr", function()
            Snacks.picker.lsp_references()
          end, "Goto references")
          map("gi", function()
            Snacks.picker.lsp_implementations()
          end, "Goto implementation")
          map("gt", function()
            Snacks.picker.lsp_type_definitions()
          end, "Goto type definition")
          map("gD", vim.lsp.buf.declaration, "Goto declaration")

          -- Actions
          map("<F2>", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>i", vim.lsp.buf.code_action, "Code action", { "n", "v" })

          -- Diagnostics
          map("<leader>dd", vim.diagnostic.open_float, "Show diagnostics")
          map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
          end, "Next diagnostic")
          map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
          end, "Prev diagnostic")
          map("]e", function()
            vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR })
          end, "Next error")
          map("[e", function()
            vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR })
          end, "Prev error")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if not client then
            return
          end

          -- Document highlight on cursor hold
          if client.supports_method(client, "textDocument/documentHighlight", buf) then
            local hl_augroup = vim.api.nvim_create_augroup("user-lsp-highlight-" .. buf, { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = buf,
              group = hl_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = buf,
              group = hl_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            -- Clean up highlight autocmds when LSP detaches
            vim.api.nvim_create_autocmd("LspDetach", {
              buffer = buf,
              once = true,
              callback = function()
                vim.api.nvim_del_augroup_by_name("user-lsp-highlight-" .. buf)
              end,
            })
          end

          -- Inlay hints
          if client.supports_method(client, "textDocument/inlayHint", buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = buf })
            map("<leader>ti", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
            end, "Toggle inlay hints")
          end
        end,
      })
    end,
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--background-index-priority=low",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--enable-config",
            "--malloc-trim",
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
        denols = {},
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
                  table.unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              completion = { callSnippet = "Replace" },
              diagnostics = { disable = { "missing-fields" } },
            },
          },
        },
        nixd = {},
        protols = {},
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              experimental = { procAttrMacros = true },
              imports = { prefix = "crate" },
              cargo = {
                loadOutDirsFromCheck = true,
                buildScripts = { enable = true },
                features = "all",
              },
              procMacro = {
                enable = true,
                attributes = { enable = true },
              },
              check = {
                command = "clippy",
                features = "all",
                extraArgs = { "--no-deps" },
              },
              checkOnSave = true,
              diagnostics = { disabled = { "unresolved-proc-macro" } },
              inlayHints = {
                bindingModeHints = { enable = true },
              },
            },
          },
        },
        systemd_ls = {},
        taplo = {},
        tinymist = {
          settings = {
            formatterMode = "typstyle",
          },
        },
        ty = {},
        typos_lsp = {},
        qmlls = {
          cmd = { "/usr/lib/qt6/bin/qmlls" },
        },
        verible = {},
        zls = {
          settings = {
            zls = {
              enable_inlay_hints = true,
              inlay_hints_show_builtin = true,
              inlay_hints_exclude_single_argument = true,
              inlay_hints_hide_redundant_param_names = false,
              inlay_hints_hide_redundant_param_names_last_token = false,
              semantic_tokens = "partial",
            },
          },
        },
      },
    },
  },
}
