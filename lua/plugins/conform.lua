return {
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        go = { 'goimports', 'gofmt' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        rust = { 'rustfmt' },
        toml = { 'taplo' },
        zig = { 'zigfmt' },
        ['*'] = { 'codespell' },
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2' },
        },
      },
    },
  },
}
