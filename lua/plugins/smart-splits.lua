return {
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      disable_multiplexer_nav_when_zoomed = false,
    },
    keys = {
      {
        "<A-h>",
        function()
          require("smart-splits").resize_left()
        end,
        mode = "n",
        desc = "Resize split left",
      },
      {
        "<A-j>",
        function()
          require("smart-splits").resize_down()
        end,
        mode = "n",
        desc = "Resize split down",
      },
      {
        "<A-k>",
        function()
          require("smart-splits").resize_up()
        end,
        mode = "n",
        desc = "Resize split up",
      },
      {
        "<A-l>",
        function()
          require("smart-splits").resize_right()
        end,
        mode = "n",
        desc = "Resize split right",
      },
      {
        "<C-h>",
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Move to left split",
      },
      {
        "<C-j>",
        function()
          require("smart-splits").move_cursor_down()
        end,
        mode = "n",
        desc = "Move to bottom split",
      },
      {
        "<C-k>",
        function()
          require("smart-splits").move_cursor_up()
        end,
        mode = "n",
        desc = "Move to top split",
      },
      {
        "<C-l>",
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Move to right split",
      },
      {
        "<leader>wh",
        function()
          require("smart-splits").swap_buf_left()
        end,
        mode = "n",
        desc = "Swap buffer left",
      },
      {
        "<leader>wj",
        function()
          require("smart-splits").swap_buf_down()
        end,
        desc = "Swap buffer down",
      },
      {
        "<leader>wk",
        function()
          require("smart-splits").swap_buf_up()
        end,
        desc = "Swap buffer up",
      },
      {
        "<leader>wl",
        function()
          require("smart-splits").swap_buf_right()
        end,
        desc = "Swap buffer right",
      },
    },
  },
}
