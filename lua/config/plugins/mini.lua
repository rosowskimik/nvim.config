return {
  {
    "echasnovski/mini.nvim",
    lazy = false,
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          require("ts_context_commentstring").setup({
            enable_autocmd = false,
          })
        end,
      },
    },
    config = function()
      require("mini.ai").setup({
        options = {
          basic = true,
          extra_ui = true,
        },
      })
      require("mini.comment").setup({
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
          end,
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
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          { mode = { "n", "x" }, keys = "<leader>" },
          { mode = { "n" }, keys = "[" },
          { mode = { "n" }, keys = "]" },
          { mode = { "i" }, keys = "<C-x>" },
          { mode = { "n", "x" }, keys = "g" },
        },
        clues = {
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
        },
        window = {
          delay = 350,
        },
      })
      require("mini.basics").setup()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.diff").setup()
      require("mini.files").setup()
      require("mini.git").setup()
      require("mini.icons").setup()
      require("mini.jump").setup()
      require("mini.operators").setup()
      require("mini.pairs").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
    end,
    keys = {
      {
        "-",
        function()
          ---@diagnostic disable-next-line: undefined-global
          MiniFiles.open()
        end,
        { desc = "Open parent directory" },
      },
      {
        "<leader>e",
        function()
          ---@diagnostic disable-next-line: undefined-global
          MiniFiles.open()
        end,
        { desc = "Open parent directory" },
      },
    },
  },
}
