return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "simrat39/rust-tools.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")

      local severity = vim.diagnostic.severity
      local diagnostic_config = {
        underline = {
          severity = { min = severity.WARN },
        },
        virtual_text = {
          severity = { min = severity.WARN },
        },
        signs = true,
      }
      vim.diagnostic.config(diagnostic_config)

      local custom_init = function(client)
        client.config.flags = client.config.flags or {}
        client.config.flags.allow_incremental_sync = true
      end

      local custom_attach = function(client, bufnr)
        require("lsp-format").on_attach(client)

        vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

        if client.server_capabilities.document_highlight then
          vim.cmd([[
          augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> silent! lua vim.lsp.buf.document_highlight()
            autocmd CursorHoldI <buffer> silent! lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> silent! lua vim.lsp.buf.clear_references()
            autocmd CursorMovedI <buffer> silent! lua vim.lsp.buf.clear_references()
          augroup END
          ]])
        end

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.buf.inlay_hint(bufnr, true)
        end
      end

      local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
      updated_capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = { "documentation", "detail", "additionalTextEdits" },
      }
      updated_capabilities = require("cmp_nvim_lsp").default_capabilities(updated_capabilities)

      local servers = {
        html = true,
        vimls = true,
        tsserver = (vim.fn.executable("typescript-language-server")),
        -- pylyzer = (1 == vim.fn.executable("pylyzer")),
        pylsp = (1 == vim.fn.executable("pylsp")),
        gopls = (1 == vim.fn.executable("gopls")),
        cmake = (1 == vim.fn.executable("cmake-language-server")),
        zls = (1 == vim.fn.executable("zls")),

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
        },

        -- rust_analyzer = {
        --   settings = {
        --     ["rust-analyzer"] = {
        --       experimental = { procAttrMacros = true },
        --       assist = {
        --         importGranularity = "crate",
        --         importPrefix = "self",
        --       },
        --       cargo = {
        --         loadOutDirsFromCheck = true,
        --         buildScripts = {
        --           enable = true,
        --         },
        --       },
        --       procMacro = {
        --         enable = true,
        --         attributes = { enable = true },
        --       },
        --       checkOnSave = {
        --         command = "clippy",
        --         features = "all",
        --         extraArgs = { "--no-deps" },
        --       },
        --     },
        --   },
        -- },
      }

      local setup_server = function(server, config)
        if not config then
          return
        end

        if type(config) ~= "table" then
          config = {}
        end

        config = vim.tbl_deep_extend("force", {
          on_init = custom_init,
          on_attach = custom_attach,
          capabilities = updated_capabilities,
          flags = { debounce_text_changes = 50 },
        }, config)

        lspconfig[server].setup(config)
      end

      for server, config in pairs(servers) do
        setup_server(server, config)
      end

      -- -- Once inlay hints released (v0.10), can be removed
      local rust_server_opts = {
        on_init = custom_init,
        on_attach = custom_attach,
        capabilities = updated_capabilities,
        flags = { debounce_text_changes = 50 },
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
          },
        }
      }

      require("rust-tools").setup({
        tools = {
          runnables = { use_telescope = true },
          hover_with_actions = false,
          inlay_hints = { highlight = "NonText" },
        },
        server = rust_server_opts,
      })
    end,

    keys = {
      { "gD", vim.lsp.buf.declaration },
      { "<leader>i", vim.lsp.buf.code_action },
      { "K", vim.lsp.buf.hover },
      { "<c-K>", vim.lsp.buf.signature_help, mode = "i" },
      { "<F2>", vim.lsp.buf.rename },
      { "<leader>[", vim.diagnostic.goto_prev },
      { "<leader>]", vim.diagnostic.goto_next },
    },
  },
}
