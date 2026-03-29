-- lua/plugins/todo-comments.lua
return {
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {
      signs = false,
    },
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Prev todo",
      },
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "Todo comments",
      },
      {
        "<leader>sT",
        function()
          Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
        end,
        desc = "Todo/Fix/Fixme",
      },
      -- Trouble keymap added later when we set up trouble.nvim
    },
  },
}
