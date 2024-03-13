return {
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = { 'ConformInfo', 'FormatDisable' },
    config = function()
      local slow_format_filetypes = {}
      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable format-on-save',
        bang = true,
      })
      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Enable format-on-save',
      })

      require('conform').setup {
        notify_on_error = true,
        formatters_by_ft = {
          bash = { 'shfmt' },
          c = { 'clang_format' },
          cpp = { 'clang_format' },
          go = { 'goimports', 'gofmt' },
          json = { 'jq' },
          lua = { 'stylua' },
          python = { { 'ruff', { 'isort', 'black' } } },
          rust = { 'rustfmt' },
          sh = { 'shfmt' },
          toml = { 'taplo' },
          zig = { 'zigfmt' },
        },
        formatters = {
          shfmt = {
            prepend_args = { '-i', '2', '-s' },
          },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat or slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          local function on_format(err)
            if err and err:match 'timeout$' then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 300, lsp_fallback = true }, on_format
        end,
        format_after_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat or not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { lsp_fallback = true }
        end,
      }
    end,
  },
}
