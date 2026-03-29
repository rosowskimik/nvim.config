return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      search = {
        multi_window = true,
      },
      label = {
        after = true,
      },
      modes = {
        char = {
          enabled = true,
          jump_labels = true,
        },
      },
    },
    keys = {
      {
        "s",
        function()
          require("flash").jump()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash jump",
      },
      {
        "S",
        function()
          require("flash").treesitter()
        end,
        mode = { "n", "x", "o" },
        desc = "Flash treesitter",
      },
      {
        "r",
        function()
          require("flash").remote()
        end,
        mode = "o",
        desc = "Flash remote",
      },
      {
        "<C-s>",
        function()
          require("flash").toggle()
        end,
        mode = "c",
        desc = "Flash toggle search",
      },
    },
  },
}
