return {
  "mrjones2014/smart-splits.nvim",
  config = {
    disable_multiplexer_nav_whe_zoomed = false,
  },
  keys = function()
    local smart_splits = require("smart-splits")
    return {
      {
        "<A-h>",
        smart_splits.resize_left,
      },
      {
        "<A-j>",
        smart_splits.resize_down,
      },
      {
        "<A-k>",
        smart_splits.resize_up,
      },
      {
        "<A-l>",
        smart_splits.resize_right,
      },
      {
        "<C-h>",
        smart_splits.move_cursor_left,
      },
      {
        "<C-j>",
        smart_splits.move_cursor_down,
      },
      {
        "<C-k>",
        smart_splits.move_cursor_up,
      },
      {
        "<C-l>",
        smart_splits.move_cursor_right,
      },
    }
  end,
}
