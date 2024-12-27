return {
  {
    "ggandor/leap.nvim",
    config = function()
      -- Define equivalence classes for brackets and quotes, in addition to
      -- the default whitespace group.
      require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

      -- Use the traversal keys to repeat the previous motion without explicitly
      -- invoking Leap.
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")
    end,
    keys = {
      {
        "s",
        "<Plug>(leap-forward)",
        mode = { "n", "x", "o" },
        desc = "Leap Forwards",
      },
      {
        "S",
        "<Plug>(leap-backward)",
        mode = { "n", "x", "o" },
        desc = "Leap Backwards",
      },
    },
  },
}
