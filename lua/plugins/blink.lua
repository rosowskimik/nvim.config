return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      appearance = {
        nerd_font_variant = "normal",
      },
      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      cmdline = {
        enabled = false,
      },
      signature = {
        enabled = true,
        window = { border = "single" },
      },
      completion = {
        keyword = { range = "full" },
        ghost_text = { enabled = true },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = { border = "single" },
        },
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline" or not vim.tbl_contains({ "/", "?" }, vim.fn.getcmdtype())
          end,
          draw = {
            treesitter = { "lsp" },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                  return icon
                end,
                highlight = function(ctx)
                  local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                  return hl
                end,
              },
            },
          },
        },
      },
    },
  },
}
