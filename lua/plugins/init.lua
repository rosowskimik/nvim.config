return {
  { "folke/lazy.nvim", version = "*" },

  {
    "mhinz/vim-sayonara",
    cmd = "Sayonara",
    keys = {
      { "<leader>q", ":Sayonara<CR>" },
      { "<leader>wq", ":w <Bar> :Format sync <Bar> Sayonara<CR>" },
    },
  },

  {
    "numToStr/FTerm.nvim",
    config = true,
    keys = {
      {
        "<leader>`",
        function()
          require("FTerm").toggle()
        end,
      },
      {
        "<leader>g",
        function()
          require("FTerm").scratch({ cmd = "lazygit" })
        end,
      },
    },
  },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },

  { "lewis6991/gitsigns.nvim", config = true },

  { "akinsho/git-conflict.nvim", version = "*", config = true },

  { "kylechui/nvim-surround", config = true },

  { "tpope/vim-sleuth" },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true

      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = false,
    },
    config = function()
      require("Comment").setup({
        mappings = false,
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
    end,
    keys = {
      {
        "<C-_>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
      },
      {
        "<C-\\>",
        function()
          require("Comment.api").toggle.blockwise.current()
        end,
      },
      {
        "<C-_>",
        function()
          local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
          vim.api.nvim_feedkeys(esc, "nx", false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end,
        mode = "v",
      },
      {
        "<C-\\>",
        function()
          local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
          vim.api.nvim_feedkeys(esc, "nx", false)
          require("Comment.api").toggle.blockwise(vim.fn.visualmode())
        end,
        mode = "v",
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    lazy = false,
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        offsets = {
          { filetype = "Neotree", text = "File Explorer", text_align = "center" },
        },
        diagnostics = "nvim_lsp",
      },
    },
    keys = {
      { "<leader><leader>", ":BufferLinePick<CR>" },
    },
  },

  {
    "HiPhish/rainbow-delimiters.nvim",
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- options = { theme = "nightfox" },
      options = { theme = "gruvbox-material" },
      extensions = { "neo-tree", "quickfix", "symbols-outline" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      whitespace = {
        remove_blankline_trail = true,
      },
      scope = { enabled = true },
    },
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }
      local hooks = require("ibl.hooks")
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup({
        scope = { highlight = highlight, enabled = true },
        whitespace = { remove_blankline_trail = true },
      })

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },

  {
    "folke/twilight.nvim",
    config = true,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      close_if_last_window = true,
      filtered_items = {
        visible = true,
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
    keys = {
      { "<leader>e", ":Neotree<CR>" },
    },
  },

  {
    "simrat39/symbols-outline.nvim",
    config = true,
    keys = {
      { "<leader>o", ":SymbolsOutline<CR>" },
    },
  },

  { "antoinemadec/FixCursorHold.nvim" },

  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      bind = true,
      handler_opts = { border = "single" },
    },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
    keys = {
      {
        "<leader>t",
        function()
          require("trouble").open("document_diagnostics")
        end,
      },
      {
        "<leader>tw",
        function()
          require("trouble").open("workspace_diagnostics")
        end,
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    config = function()
      local ls = require("luasnip")
      local types = require("luasnip.util.types")

      ls.config.setup({
        history = false,
        updateevents = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "●", "GruvboxOrange" } },
            },
          },
          [types.insertNode] = {
            active = {
              virt_text = { { "●", "GruvboxBlue" } },
            },
          },
        },
      })
    end,
  },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = true,
  },
}
