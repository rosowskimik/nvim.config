return {
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    opts = {
      outline_window = {
        auto_close = true,
        auto_jump = true,
      },
    },
    keys = {
      { "<leader>o", "<cmd>Outline<cr>", desc = "Toggle outline" },
    },
  },
}
