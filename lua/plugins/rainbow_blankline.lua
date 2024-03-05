local highlights = {
  RainbowRed = '#E06C75',
  RainbowYellow = '#E5C07B',
  RainbowBlue = '#61AFEF',
  RainbowOrange = '#D19A66',
  RainbowGreen = '#98C379',
  RainbowViolet = '#C678DD',
  RainbowCyan = '#56B6C2',
}

return {
  {
    -- requires Treesitter to work
    'HiPhish/rainbow-delimiters.nvim',
    config = function()
      local rainbow_delimiters = require 'rainbow-delimiters'

      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = vim.tbl_keys(highlights),
      }
    end,
  },
  {
    -- requires Treesitter for rainbow lines to work
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    main = 'ibl',
    config = function()
      local hooks = require 'ibl.hooks'
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        for key, val in pairs(highlights) do
          vim.api.nvim_set_hl(0, key, { fg = val })
        end
      end)

      require('ibl').setup {
        scope = { enabled = true, highlight = vim.tbl_keys(highlights) },
        whitespace = { remove_blankline_trail = true },
      }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
