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
          require("FTerm").run("lazygit")
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

  { "kylechui/nvim-surround", config = true },

  { "tpope/vim-sleuth" },

  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = false,
    },
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
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "nightfox" },
      extensions = { "neo-tree", "quickfix", "symbols-outline" },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "┊",
      show_trailing_blankline_indent = false,
    },
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
