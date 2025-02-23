return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo", "FormatDisable" },
    config = function(_, opts)
      opts = opts or {}

      local slow_format_filetypes = {}
      opts.format_on_save = function(bufnr)
        if
          vim.g.disable_autoformat
          or vim.b[bufnr].disable_autoformat
          or slow_format_filetypes[vim.bo[bufnr].filetype]
        then
          return
        end
        local function on_format(err)
          if err and err:match("timeout$") then
            slow_format_filetypes[vim.bo[bufnr].filetype] = true
          end
        end

        return { timeout_ms = 500, lsp_format = "fallback" }, on_format
      end

      opts.format_after_save = function(bufnr)
        if
          vim.g.disable_autoformat
          or vim.b[bufnr].disable_autoformat
          or not slow_format_filetypes[vim.bo[bufnr].filetype]
        then
          return
        end
        return { lsp_format = "fallback" }
      end

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable format-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Enable format-on-save",
      })

      require("conform").setup(opts)
    end,
    opts = {
      notify_on_error = false,
      default_format_opts = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        bash = { "shfmt" },
        bzl = { "buildifier" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "goimports", "gofmt" },
        gn = { "gn" },
        javascript = { "deno_fmt" },
        json = { "deno_fmt" },
        lua = { "stylua" },
        latex = { "latexindent" },
        proto = { "buf" },
        python = { "ruff_organize_imports", "ruff_format" },
        markdown = { "mdformat", "injected" },
        nix = { "nixfmt" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        toml = { "taplo" },
        typescript = { "deno_fmt" },
        zig = { "zigfmt" },
        zsh = { "shfmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-s" },
        },
      },
    },
  },
}
