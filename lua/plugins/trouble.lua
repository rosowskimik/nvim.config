return {
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      focus = true,
      win = { border = "single" },
      modes = {
        lsp = {
          mode = "lsp",
          win = { relative = "win", position = "right", size = 0.3 },
        },
        lsp_references = {
          mode = "lsp_references",
          win = { relative = "win", position = "right", size = 0.3 },
        },
      },
    },
    keys = {
      -- Diagnostics
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace diagnostics" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },

      -- LSP
      { "<leader>xl", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/defs" },

      -- Quickfix / loclist
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },

      -- snacks.picker results in trouble
      { "<leader>xp", "<cmd>Trouble snacks toggle<cr>", desc = "Picker results" },

      {
        "[x",
        function()
          require("trouble").prev({ skip_groups = true, jump = true })
        end,
        desc = "Prev trouble item",
      },
      {
        "]x",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Next trouble item",
      },
    },
  },
}
