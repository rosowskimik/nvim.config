return {
  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.comment").setup()
      require("mini.operators").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()

      -- Mock web-devicons API for other plugins
      require("mini.icons").setup()
      MiniIcons.mock_nvim_web_devicons()

      require("mini.ai").setup({
        options = {
          basic = true,
          extra_ui = true,
        },
      })

      require("mini.move").setup({
        mappings = {
          left = "H",
          right = "L",
          down = "J",
          up = "K",
          line_left = "",
          line_right = "",
          line_down = "",
          line_up = "",
        },
      })
    end,
    keys = {
      {
        "<leader>fw",
        function()
          MiniTrailspace.trim()
        end,
        desc = "Trim trailing whitespace",
      },
      {
        "<leader>fW",
        function()
          MiniTrailspace.trim_last_lines()
        end,
        desc = "Trim trailing empty lines",
      },
    },
  },
}
